require 'spec_helper'

describe Session do  
  let(:session) {Fabricate(:session, :tags_array => %w(courage respect))}

  it 'can hold an array of tag' do
    assert {session.tags_array.include?('courage')}
  end
  
  it 'can be queried for a tag' do
    # somehow clumsy statement : we need session to be created before searching for it ...
    assert {session.tags_array.size == 2}
    # look for it now ?
    sessions = Session.any_in(:tags_array => ['courage'])
    assert {sessions.first == session}
  end
  
  it {should have_fields(:created_at, :updated_at).of_type(Time)}
  
  describe "choices" do
    it {should have_fields(:level, :age, :format)}
  end
  
  describe "capacity" do
    it {should have_fields(:capacity).of_type(Integer)}
    it {should validate_numericality_of :capacity}
  end
end
