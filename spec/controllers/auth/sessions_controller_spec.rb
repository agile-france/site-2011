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
  
  describe "#new" do
    context "session carry twitter authentication data and email" do
      render_views
      before do
        session['auth'] = Authentications::Twitter.data.merge('email' => 'p@ni.ni')
        get :new
      end
      it "has password field" do
        response.body.should have_tag 'input[id="user_password"]'
      end
      it "has email filled in" do
        response.body.should have_tag 'input[id="user_email"][value="p@ni.ni"]'
      end
    end
  end
  
  describe "#create" do
    context "session carry twitter authentication data and email" do
      let(:joe) {Fabricate :user}
      before do
        session['auth'] = Authentications::Twitter.data.merge('email' => 'p@ni.ni')
        post :create, :user => {:email => joe.email, :password => joe.password}
      end
      it "add authentication to joe" do
        # joe = User.identified_by_email(joe.email)
        joe.reload
        assert {joe.authentications.first}
      end
    end
  end
end