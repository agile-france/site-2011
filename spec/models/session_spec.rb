require 'spec_helper'

describe Session do
  before do
    # do create object before each and have a handy :session reader
    @session = Fabricate(:session, :tags_array => %w(courage respect))
    class << self; self end.module_eval {attr_reader :session}
  end

  it 'can hold an array of tag' do
    assert {session.tags_array.include?('courage')}
  end
  
  it 'can be queried for a tag' do
    sessions = Session.any_in(:tags_array => ['courage'])
    assert {sessions.first == session}
  end
end
