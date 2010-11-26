require 'spec_helper'

describe Admin::UsersController do 
  context 'admin is logged in' do
    let(:user) {Fabricate(:user, :email => 'donotforget@thedonuts.com')}
    before do
      sign_in(Fabricate(:user, :admin => true))
    end
    
    describe "GET users" do
      it 'should propose list of users' do
        get :index
        response.should be_success
      end
    end
    
    describe "GET 'edit'" do
      it "should be successful" do
        get :edit, :id => user.id
        response.should be_success
      end
    end

    describe "GET 'update'" do
      it "update admin flag" do
        put :update, :id => user.id, :user => {:admin => true}
        response.should redirect_to(admin_users_path)
        assert {user.reload.admin?}
      end
    end
  end
end
