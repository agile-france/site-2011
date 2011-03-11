require 'spec_helper'

describe Admin::UsersController do

  (0..9).each do |i|
    touch_db_with("user_#{i}".to_sym) {Fabricate(:user, :email => "email-#{i}@noreply.com", :password => 'awesome cooking')}
  end

  context 'admin is logged in' do
    touch_db_with(:admin) {Fabricate(:user, :admin => true)}
    before do
      sign_in(admin)
    end
    describe "GET users" do
      it 'should propose list of users' do
        get :index
        response.should be_success
      end

      describe 'search' do
        let(:email) {"email-0@noreply.com"}

        it "should find one exact match on email" do
          get :index, :q => email
          assigns(:users).should == User.where(:email => email)
        end
        it "should find regular match" do
          get :index, :q => "/-0/"
          assigns(:users).should == User.where(:email => email)
        end
        it "should return all when query is blank" do
          get :index, :q => ""
          assigns(:users).should == User.all
        end        
      end      
    end

    describe "GET 'edit'" do
      it "should be successful" do
        get :edit, :id => admin.id
        response.should be_success
      end
    end

    describe "GET 'update'" do
      it "update admin flag" do
        put :update, :id => admin.id, :user => {:admin => false}
        response.should redirect_to(admin_users_path)
        deny {admin.reload.admin?}
      end
    end
  end
  
  it 'redirects unsigned user to sign' do
    get :index
    response.should redirect_to new_user_session_path
  end
  context "user is signed in" do
    touch_db_with(:joe) {Fabricate(:user)}
    before do
      sign_in(joe)
    end
    it 'redirect regular user to root_path' do
      get :index
      response.should redirect_to root_path
    end
  end
end
