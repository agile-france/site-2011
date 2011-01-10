require 'spec_helper'

# devise integration test, with adapted behavior, to handle external authentication
#
describe Auth::RegistrationsController do
  before do
    # see https://github.com/plataformatec/devise/issues/issue/608
    # or http://www.lostincode.net/blog/testing-devise-controllers
    request.env['devise.mapping'] = Devise.mappings[:user]    
  end

  describe "GET /users/sign_in" do
    # integration test
    render_views
    context "with twitter authentication data" do
      before do
        session[:auth] = Authentications::Twitter.data
        get :new
      end
      it "GET /users/sign_up does not have password field" do
        response.body.should_not have_tag 'input[id="user_password"]'
      end

      it "show email validation error" do
        response.body.should have_tag '#error_explanation' do |exp|
          exp.should have_tag '*', /email (.*) rempli/i
        end
      end
    end
  end

  describe "POST /users with email" do
    # integration test
    render_views
    context "with twitter authentication data" do
      before do
        session[:auth] = Authentications::Twitter.data
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
  
  describe "build_resource" do
    # testing protected method defined in devise ... a bit scary ...
    context "with github authentication data" do
      before do
        session[:auth] = Authentications::Github.data
        @user = controller.send :build_resource
      end
      it 'should have an email' do
        assert {@user.email == 'thierry.henrio@gmail.com'}
      end
    end
  end
end