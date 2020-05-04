require 'psych'

module CurseTool
  class ManifestParser
    @parser = Psych
    class << self; attr_reader :parser end

    def parse(manifest_file)
      yaml = File.read(manifest_file)
      Psych.load(yaml, symbolize_names: true)
    end


  end
end