require 'spec_helper'

describe AccountController do
  context 'with a sign in user' do
    before do
      @user = Fabricate(:user)
      sign_in @user
    end
    
    describe "GET /account/edit" do
      it "should be successful" do
        get :edit
        response.should be_success
      end
    end
    
    describe "POST /account" do
      it 'should update user sent attributes' do
        put :update, :user => {:bio => 'man'}
        assert {response.location =~ /#{edit_account_path}/}
        assert {@user.reload.bio == 'man'}
      end
    end
  end
  
  context 'with no user signed in' do
    describe "GET /account/edit" do
      it "should redirect to /users/sign_in" do
        get :edit
        response.should redirect_to(new_user_session_path)
      end
    end    
  end
end
