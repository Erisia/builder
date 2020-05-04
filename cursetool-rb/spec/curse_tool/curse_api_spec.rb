require 'rspec'
require 'curse_tool/curse_api'

describe 'CurseTool::CurseApi' do
  let!(:curse_api) { CurseTool::CurseApi }

  context :integration do
    # Sanity check so i'll be alerted if curse changes stuff in their api that would break this.
    it 'returns results containing the expected structure for search mod' do
      expect(curse_api.search_mods('thaumcraft', '1.12.2').first.keys).to include(:id, :slug)
    end

    it 'returns results containing the expected structure for get file' do
      expect(curse_api.file(223628).first.keys).to include(:downloadUrl, :releaseType)
    end
  end
end