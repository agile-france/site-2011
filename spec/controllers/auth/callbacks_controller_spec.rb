require 'spec_helper'

describe Auth::CallbacksController do
  # before(:suite) do
  #   Devise::OmniAuth.test_mode!
  #   Devise::OmniAuth.short_circuit_authorizers!
  # end
  # after(:suite) do
  #   Devise::OmniAuth.unshort_circuit_authorizers!
  # end
  before do
    # see https://github.com/plataformatec/devise/issues/issue/608
    # or http://www.lostincode.net/blog/testing-devise-controllers
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "GET /users/auth/twitter/callback" do
    before do
      # this is a piece of information sent from twitter
      request.env['omniauth.auth'] = Authentications::Twitter.data
      assert {Authentications::Twitter.data['extra'] =~ /CookieOverflow$/}
    end
    context "no user having provider and uid" do
      before do
        get :twitter
      end
      it 'redirects to user sign up page, requiring to fill in email' do
        response.should redirect_to new_user_registration_path
      end
      it 'should have twitter authentication data available in session[:auth]' do
        assert {session[:auth] == Authentications::Twitter.data.except('credentials', 'extra')}
      end
    end
    context "with an authorized user, old data" do
      before do
        u = Fabricate(:user)
        auth = u.authentications.create!(Authentications::Twitter.data.merge({'user_info' => {'image' => 'oops'}}))
        get :twitter
      end
      it 'redirects to root_path' do
        response.should redirect_to root_path
      end
      it 'sign in user' do
        assert {controller.current_user}
      end
      it 'should activate authentication with fresh data' do
        auth = controller.current_user.authentications.first
        assert {auth.activated?}
        assert {auth.user_info['image'] == Authentications::Twitter.data['user_info']['image']}
      end
    end
  end

  describe "GET /users/auth/github/callback" do
    before do
      # this is a piece of information sent from github
      request.env['omniauth.auth'] = Authentications::Github.data
    end
    context "no user having email provided in authentication" do
      before do
        get :github
      end
      it 'redirects to root_path, creates user, with generated password and signs him in' do
        response.should redirect_to root_path
        current_user = controller.current_user
        deny {current_user.encrypted_password.blank?}
      end
    end
    context "user with same email as in authentication data exists" do
      before do
        @user = User.create!({:password => 'sha-1024'}.merge(Authentications::Github.data['user_info']))
        get :github
      end
      it 'redirects to root_path' do
        response.should redirect_to root_path
      end
      it 'user is signed in, and authentication added to user' do
        current_user = controller.current_user
        assert {current_user == @user}
        deny {current_user.authentications.empty?}
      end
      it 'do not carry auth information in session' do
        deny {session[:auth]}
      end
      it 'user has an authentication, with public information at hand' do
        authentication = controller.current_user.authentications.first
        assert {authentication.user_info}
      end
    end
  end
end