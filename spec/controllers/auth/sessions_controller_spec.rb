require 'spec_helper'

describe Auth::SessionsController do
  before do
    # see https://github.com/plataformatec/devise/issues/issue/608
    # or http://www.lostincode.net/blog/testing-devise-controllers
    request.env['devise.mapping'] = Devise.mappings[:user]    
  end
    
  describe "#destroy" do
    context "user has an activated authentication" do
      let(:user) {Fabricate :user}
      before do
        user.authentications.create(:activated => true)
        sign_in(user)
      end
      it 'desactivates authentication' do
        get :destroy
        o = user.authentications.first
        assert {o.deactivated?}
      end
    end
  end
end