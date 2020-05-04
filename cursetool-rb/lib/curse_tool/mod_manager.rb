require_relative 'curse_api'
require 'fileutils'
require 'xdg'

module CurseTool
  module ModManager
    extend self
    attr_reader :seen_mods, :seen_hashes
    @seen_mods = {}
    @seen_hashes = {}

    xdg = XDG::Environment.new
    if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
      HOME = "#{ENV['USERPROFILE']}/AppData/Local/"
      CACHE_HOME = File.join(HOME, 'cursetool-rb')
    else
      HOME = xdg.config_home
      CACHE_HOME = xdg.cache_home
    end
    CACHE_LOCATION = File.join(CACHE_HOME, 'mod_cache.yaml')
    HASH_CACHE_LOCATION = File.join(CACHE_HOME, 'hash_cache.yaml')

    def pull_mods(version)
      retries ||= 0
      if File.exist?(CACHE_LOCATION)
        @seen_mods = Psych.load(File.open(CACHE_LOCATION))
      end
      if File.exist?(HASH_CACHE_LOCATION)
        @seen_hashes = Psych.load(File.open(HASH_CACHE_LOCATION))
      end
      if !@seen_mods || @seen_mods.empty?
        results = CurseApi.search_mods(version.split('.')[0..1].join('.'))
        results.concat CurseApi.search_mods(version)
        results.uniq!
      end
      results ||= []
      results.each do |result|
        @seen_mods[result[:slug].to_sym] = result
      end
    rescue NoMethodError => e
      File.delete(CACHE_LOCATION) if File.exist? CACHE_LOCATION
      File.delete(HASH_CACHE_LOCATION) if File.exist? HASH_CACHE_LOCATION
      @seen_mods = {}
      @seen_hashes = {}
      retry if (retries += 1) <= 1
      throw e
    end

    def expand_info(mod_info)
      mod_hash = lookup_mod(mod_info) unless full_mod_def?(mod_info)
      mod_info.from_curse(mod_hash) if mod_hash
      mod_info.populate_file
    end

    def full_mod_def?(mod_info)
      mod_info.title && mod_info.id && mod_info.filename &&
        mod_info.src && (mod_info.md5 || mod_info.sha256)
    end

    def lookup_mod(mod_info)
      slug = mod_info.name
      return @seen_mods[slug.to_sym] if @seen_mods[slug.to_sym]
      found_mod = @seen_mods.values.find{|it| it[:id] == mod_info.id}
      return found_mod if found_mod
      return find_mod(mod_info.id) if mod_info.id
      warn("No mod found matching #{slug} on CurseForge.  Can try adding id: key to manifest to force find it.")
    end

    def find_mod(mod_id)
      found_mod = @seen_mods.values.find{|it| it[:id] == mod_id}
      unless found_mod
        found_mod = CurseApi.get_mod(mod_id)
        add_mod(found_mod)
      end
      found_mod
    end

    def add_mod(mod_info)
      @seen_mods[mod_info[:slug]] = mod_info
    end

    def dump!
      FileUtils.mkdir_p CACHE_HOME
      File.open(CACHE_LOCATION, 'w') { |f| Psych.dump(@seen_mods, f) }
      File.open(HASH_CACHE_LOCATION, 'w') { |f| Psych.dump(@seen_hashes, f) }
    end

    at_exit do
      dump!
    end

  end
end
