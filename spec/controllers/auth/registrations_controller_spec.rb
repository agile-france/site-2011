require 'spec_helper'

describe Auth::RegistrationsController do
  context "with twitter authentication data" do
    render_views
    before do
      # see https://github.com/plataformatec/devise/issues/issue/608
      # or http://www.lostincode.net/blog/testing-devise-controllers
      request.env['devise.mapping'] = Devise.mappings[:user]
      session[:auth] = Twitter.data
    end
    
    it "GET /users/sign_up does not have password field" do
      get :new
      response.body.should_not have_tag 'input[id="user_password"]'
    end
    
    describe "POST /users with email" do
      before do
        post :create, :user => {:email => 'no@name.org'}
      end
      it "should redirect to root_path" do
        response.should redirect_to root_path
      end
      it "creates a new user with provided email" do
        user = User.where(:email => 'no@name.org').first
        assert {user}
      end
      it "cleans :auth from session" do
        deny {session[:auth]}
      end
    end
  end
end