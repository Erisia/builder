module CurseTool
  class << self
    def require(mod_name)
      require_relative "curse_tool/#{mod_name}"
    end
  end
end

CurseTool.require(:cli)
CurseTool.require(:curse_api)
CurseTool.require(:manifest_parser)
CurseTool.require(:mod_manager)
CurseTool.require(:models)
CurseTool.require(:nix_writer)