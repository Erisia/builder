require 'rspec'
require 'curse_tool/mod_manager'

describe 'CurseTool::ModManager' do
  before { stub_const('CurseTool::CurseApi', class_double('CurseTool::CurseApi')) }
  let!(:mod_manager) { CurseTool::ModManager }
end