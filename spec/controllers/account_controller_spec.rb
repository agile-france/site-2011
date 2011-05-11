require 'spec_helper'

describe AccountController do
  context 'with a sign in user' do
    touch_db_with(:user) {Fabricate(:user)}
    before do
      sign_in user
    end

    describe "GET /account/edit" do
      it "should be successful" do
        get :edit
        response.should be_success
      end
    end

    describe "POST /account" do
      it 'update user sent attributes' do
        put :update, :user => {:bio => 'man'}
        assert {response.location =~ /#{edit_account_path}/}
        assert {user.reload.bio == 'man'}
      end
      it 'update user optins' do
        deny {user.optin?(:sponsors)}
        put :update, :optins => {'sponsors' => 'accept'}
        assert {user.reload.optin?(:sponsors)}
      end
      it 'updates user company' do
        awe = Fabricate(:company, :name => 'awe')
        put :update, :company => {:name => 'awe'}
        assert {user.reload.company == awe}
      end
    end

    describe "DELETE /account" do
      before do
        delete :destroy
      end
      it "redirects to home" do
        assert {response.location = root_path}
      end
      it "kills user" do
        assert {User.criteria.for_ids(user.id).empty?}
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
