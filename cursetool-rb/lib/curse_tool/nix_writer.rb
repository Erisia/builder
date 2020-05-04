module CurseTool
  module NixWriter
    class << self
      def dump(object, file_name)
        file = File.open(file_name, 'w')
        file.truncate(0)
        object.dump(file)
      end
    end
  end
end