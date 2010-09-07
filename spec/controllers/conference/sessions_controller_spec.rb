#encoding: utf-8
require 'spec_helper'

describe Conference::SessionsController do
  include Devise::TestHelpers

  describe ', with a signed in user' do
    before do
      @john = Factory.create(:user)
      sign_in @john
    end

    describe ", GET new" do
      it "should be successful" do
        get :new
        assigns(:session).should be_a_new(::Session)
        response.should be_success
      end
    end

    describe ", POST create" do
      before do
        @params={:title => 'amazing story', :description => '...'}
        ::Session.where(@params).first.should be_nil
        post :create, :session => @params
      end

      it 'should create a new record' do
        ::Session.where(@params).first.should_not be_nil
      end

      it "should redirect to home" do
        response.should redirect_to root_path
      end

      it "should flash success" do
        flash[:notice].should =~ /créée!/
      end
    end
  end

  describe ', with a signed off user' do
    describe ", GET new" do
      before do
        get :new
      end
      it "should redirect user to sign_in url" do
        response.should redirect_to new_user_session_path
      end
      it "should have a flash alert" do
        flash[:alert].should_not be_nil
      end
    end
  end

  describe 'index' do
    before do
      @sessions = ['courage', 'respect'].map {|title| Factory(:session, :title => title)}
    end
    
    it 'should show proposed sessions' do
      get :index
      assigns(:sessions).should == @sessions
      response.should be_success
    end
  end
end
