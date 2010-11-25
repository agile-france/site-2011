require 'spec_helper'

describe Admin::UsersController do
  let(:user) {Fabricate(:user, :email => 'donotforget@thedonuts.com')}
  context 'admin is logged in' do
    before do
      sign_in(Fabricate(:user, :admin => true))
    end
    
    describe "GET users" do
      it 'should propose list of users' do
        get :index
        reponse.should be_success
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
        put :update, :id => user.id
        response.should redirect_to(admin_users_path)
      end
    end
  end
end
