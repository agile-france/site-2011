require 'spec_helper'

describe Conference do
  let(:xp) {Fabricate(:conference, :name => 'foocon', :edition => '2012')}
  it 'has a conpound id : #{name}-#{edition}' do
    assert {xp.id == "#{xp.name}-#{xp.edition}"}
  end
end