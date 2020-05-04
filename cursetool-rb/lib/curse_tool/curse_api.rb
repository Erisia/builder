require 'net/http'
require 'json'

module CurseTool
  class CurseApi
    @base_uri = 'https://addons-ecs.forgesvc.net/api/v2'
    @seen_mods = {}

    class << self
      def search_mods(version)
        uri = URI(@base_uri + '/addon/search')
        params = {
          gameId: 432, # minecraft
          gameVersion: version,
          sort: 3, # Relevance
          sectionId: 6, # minecraft mods
          pageSize: 10000
        }
        uri.query = URI.encode_www_form(params)
        JSON.parse(with_pool { |client| client.get_response(uri) }.body, symbolize_names: true)
      end

      def get_mod(mod_id)
        uri = URI(@base_uri + "/addon/#{mod_id}")
        response = with_pool { |client| client.get_response(uri) }
        JSON.parse(response.body, symbolize_names: true)
      end

      def files(mod_id)
        uri = URI(@base_uri + "/addon/#{mod_id}/files")
        response = with_pool { |client| client.get_response(uri) }
        JSON.parse(response.body, symbolize_names: true)
      end

      def file(id, mod_id)
        uri = URI(@base_uri + "/addon/#{mod_id}/file/#{id}/")
        response = with_pool { |client| client.get_response(uri) }
        JSON.parse(response.body, symbolize_names: true)
      end

      def with_pool
        # Hook to implement connection pool if needed
        yield(Net::HTTP)
      end
    end
  end
end

# CurseTool::CurseApi.search_mods('applied-energistics-2')
