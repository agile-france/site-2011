require 'spec_helper'

describe Admin::UsersController do

  before(:all) do
    (0..9).each { |i| 
      Fabricate(:user, :email => "email-#{i}@noreply.com", :password => 'awesome cooking')
    }
  end

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
  
  it 'redirects unsigned user to sign' do
    get :index
    response.should redirect_to new_user_session_path
  end
  it 'redirect regular user to root_path' do
    joe = Fabricate(:user)
    sign_in(joe)
    get :index
    response.should redirect_to root_path
  end
end
