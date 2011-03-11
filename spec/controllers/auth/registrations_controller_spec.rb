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

  describe "POST /users" do
    describe "with optins" do
      before {post :create, :user => {:email => 'no@name.org', :password => 'secret', :password_confirmation => 'secret'}, :optins => {:sponsors => 'accept'}}
      def joe; User.identified_by_email 'no@name.org'; end
      after {joe.destroy}      
      
      it "saves optins" do
        post :create, :user => {:email => 'no@name.org', :password => 'secret', :password_confirmation => 'secret'}, :optins => {:sponsors => 'accept'}
        nameless = User.identified_by_email('no@name.org')
        assert {nameless.optin?(:sponsors)}
      end
    end
    
    context "with twitter authentication data" do
      before do
        session[:auth] = Authentications::Twitter.data
      end
      context "email is free" do
        before {post :create, :user => {:email => 'no@name.org'}}
        def joe; User.identified_by_email 'no@name.org'; end
        after {joe.destroy}
        
        it "should redirect to user root path" do
          response.should redirect_to edit_account_path
        end
        it "creates a new user with provided email" do
          assert {joe.email = 'no@name.org'}
        end
        it "generates a password for user" do
          deny {joe.encrypted_password.blank?}
        end
        it "cleans :auth from session" do
          deny {session[:auth]}
        end
        it "creates an associated authentication for user, with provider data" do
          a = Authentication.where(:user_id => joe.id).first
          assert {a.user_info['nickname'] == 'thierryhenrio'}
        end
      end
      
      context "email is in use" do
        touch_db_with(:doe) {Fabricate :user}
        before do
          post :create, :user => {:email => doe.email, :first_name => ''}
        end
        it 'redirects to /users/sign_in' do
          response.should redirect_to new_user_session_path
        end
        it 'save email in session' do
          assert {session[:auth]['email'] == doe.email}
        end
      end
    end
  end
end