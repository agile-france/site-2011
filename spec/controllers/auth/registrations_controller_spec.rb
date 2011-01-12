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
    context "with twitter authentication data" do
      before do
        session[:auth] = Authentications::Twitter.data
      end
      context "email is free" do
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
      context "email is in use" do
        let(:joe) {Fabricate :user}
        before do
          post :create, :user => {:email => joe.email, :first_name => ''}
        end
        it 'redirects to root_path' do
          response.should redirect_to root_path
        end
        it 'logs joe in' do
          current_user = controller.current_user
          assert {current_user == joe}
        end
        it 'joe has a new authentication with provider user_info' do
          a = Authentication.where(:user_id => joe.id).first
          assert {a.user_info['nickname'] == 'thierryhenrio'}
        end
      end
    end
  end
end