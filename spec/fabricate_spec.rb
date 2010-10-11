require 'spec_helper'
RSpec.configure do |config|
  config.include Wrong::Assert
end

def fabricate_then_find(id)
  xp = Fabricate(:conference, :id => id, :name => 'xp')
  assert {Conference.find(id) == xp}
end
def create_then_find(id)
  xp = Conference.create(:id => id, :name => 'xp')
  debugger
  assert {Conference.find(id) == xp}
end

describe 'Fabricator' do
  describe 'we should find what we created' do
    it 'find provided integer :id' do
      fabricate_then_find 1
    end
    it 'find provided string :id' do
      fabricate_then_find '123456789012345678901234'
    end
  end
end

describe 'mere create' do
  describe 'we should find what we created' do
    it 'find provided integer :id' do
      create_then_find 1
    end
    it 'find provided string :id' do
      create_then_find '123456789012345678901234'
    end
  end
end
