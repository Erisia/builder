require 'set'
require 'digest'
require 'digest/sha2'
require 'open-uri'
require 'addressable/uri'
require 'date'

module CurseTool
  MATURITY = [nil, :release, :beta, :alpha].freeze
  SIDE = [:server, :pool, :both]

  class NixPack
    attr_accessor :version, :imports, :mod_list, :dep_list
    def initialize(**hash)
      self.version = hash[:version]
      self.imports = hash[:imports]
      self.mod_list = NixPackModList.new(self, hash[:mods])
      self.dep_list = []
    end

    def mods
      @mod_list.mods
    end

    def dependencies
      @dep_list
    end

    def dump(file)
      file.truncate(0)
      file.write(%({\n  "version" = "#{version}";\n  "imports" = [];\n  "mods" = {\n))
      deps = @dep_list.each_with_object({}) { |pack_mod, hash| hash[pack_mod.name.to_sym] = pack_mod }
      @mod_list.mods.merge!(deps)
      @mod_list.dump(file)
      file.write(%(\n\t};\n}))
    end
  end

  class NixPackModList
    attr_accessor :mods
    def initialize(pack, array)
      self.mods = array.each_with_object(Hash.new){ |mod, hash|
        hash[mod[:name].to_sym] = NixPackMod.new(pack, mod)
      }
    end

    def dump(file)
      @mods.reject{|_, value| value.id.nil?}.each do |key, value|
        file.write(%(    "#{key.to_s}" = ))
        file.write("#{value.dump}\n")
      end
    end
  end

  class NixPackMod
    attr_accessor :title, :name, :id, :side, :required, :default, :deps, :filename, :encoded, :page, :src, :type, :sha256, :pack, :maturity, :md5, :size
    def self.from_curse_id(curse_id, parent_mod)
      curse_result = ModManager.find_mod(curse_id)
      mod = new(parent_mod.pack)
      mod.from_curse(curse_result)
      mod
    end

    def initialize(pack, **hash)
      self.pack = pack
      self.title = hash[:title]
      self.name = hash[:name]&.to_sym
      self.id = hash[:id]
      self.side = hash[:side]&.to_sym || SIDE[2]
      self.required = hash[:required]
      self.required = true if required.nil?
      self.default = hash[:default]
      self.default = true if default.nil?
      self.deps = []
      self.filename = hash[:filename]
      self.encoded = hash[:encoded]
      self.page = hash[:page]
      self.src = hash[:src]
      self.type = hash[:type] || 'remote'
      self.md5 = hash[:md5]
      self.sha256 = hash[:sha256]
      self.maturity = MATURITY.index(hash[:maturity]&.to_sym || :release)
      self.size = -1
    end


    def from_curse(hash)
      self.title = hash[:name]
      self.name = hash[:slug]
      self.id = hash[:id]
      self
    end

    def populate_file
      return if !id || (filename && src)
      files = CurseApi.files(id)
      filename ? by_filename(files) : by_maturity(files)
      @file[:dependencies].select{|it| it[:type] == 3}.each do |it|
        pack_mod = NixPackMod.from_curse_id(it[:addonId], self)
        found_mod = pack.mods.values.find { |other_mod| other_mod.id == pack_mod.id }
        if found_mod
          warn "#{name} has dependency for #{found_mod.name}, however it was also listed in the manifest. Using defined manifest mod."
        else
          pack.dependencies << pack_mod unless pack.dependencies.include? pack_mod
        end
      end
      set_hashes
      self
    end

    def set_hashes
      self.sha256, self.md5, self.size = ModManager.seen_hashes[filename] ||= self.create_hash
    end

    def get_data
      open(src, &:read)
    rescue OpenURI::HTTPError => e
      warn "Failed to caculate hash on #{self.name} due to #{e.class}, #{e.message}, trying to follow curse's redirect instead"

      self.src = src.gsub('media', 'edge')
      open(self.src, &:read)
    end

    def create_hash
      data = self.get_data
      sha256 = Digest::SHA2.new(256).update(data).to_s
      md5 = Digest::MD5.new().update(data).to_s
      size = data.length
      return sha256, md5, size
    end

    def by_maturity(files)
      files = files.sort_by{|it| DateTime.parse(it[:fileDate]) }.reverse
      @file = files.find{|it| it[:releaseType] == maturity && it[:gameVersion].include?(pack.version) }
      @file ||= files.find{|it| it[:releaseType] == maturity + 1 && it[:gameVersion].include?(pack.version) }
      @file ||= files.find{|it| it[:releaseType] == maturity + 2 && it[:gameVersion].include?(pack.version) }
      @file ||= files.find{|it| it[:releaseType] == maturity && it[:gameVersion].include?(pack.version.split('.')[0..1].join('.')) }
      @file ||= files.find{|it| it[:releaseType] == maturity + 1 && it[:gameVersion].include?(pack.version.split('.')[0..1].join('.')) }
      @file ||= files.find{|it| it[:releaseType] == maturity + 2 && it[:gameVersion].include?(pack.version.split('.')[0..1].join('.')) }
      unless @file
        return warn("no file found for #{name} in any maturity for #{pack.version}")
      end
      self.filename = @file[:fileName]
      self.src = Addressable::URI.encode(@file[:downloadUrl]).gsub('edge', 'media').gsub('+', '%2B')
    end

    def by_filename(files)
      @file = files.find{|it| it[:fileName] == filename}
      self.src = Addressable::URI.encode(@file[:downloadUrl]).gsub('edge', 'media')
    end

    def dump
      encoded = Addressable::URI.encode(filename)
      hash = {
          title: title.to_s,
          name: name.to_s,
          id: id,
          side: side.to_s,
          required: required,
          default: default,
          deps: deps,
          filename: filename.to_s,
          encoded: encoded.to_s,
          page: page.to_s,
          src: src.to_s,
          type: type.to_s,
          size: size,
      }
      hash[:md5] = md5.to_s if md5
      hash[:sha256] = sha256.to_s if sha256
      hash.transform_keys(&:to_s).to_s.gsub('>', '').gsub(',', ';').insert(-2, ';') << ';'
    end
  end

end
