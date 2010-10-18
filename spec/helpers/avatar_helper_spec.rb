require 'spec_helper'

describe AvatarHelper do
  describe '#gravatar_for' do
    context 'user has a gravatar' do
      let(:user) {Fabricate(:user, :avatar => :gravatar)}
      it 'returns an img tag to user\'s gravatar' do
        doc = doc(gravatar_for(user))
        assert {doc.at_xpath('//img/@src').value =~ %r{^http://www.gravatar.com/avatar/}}
      end
    end
  end
end
