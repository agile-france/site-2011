require 'spec_helper'

describe AvatarHelper do
  describe '#avatar_for' do
    context 'user has a gravatar' do
      let(:user) {Fabricate :user}
      it 'returns an img tag to user\'s gravatar' do
        doc = doc(avatar_for(user))
        assert {doc.at_xpath('//img/@src').value =~ %r{^http://www.gravatar.com/avatar/}}
      end
    end
  end
end
