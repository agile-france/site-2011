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
        response.should be_success
      end
    end

    describe ", POST create" do
      it "should be successful" do
        post :create
        response.should redirect_to root_path
      end
    end
  end

  describe ', with a signed off user' do
    describe ", GET new" do
      it "should not be granted and have a flash notice" do
        get :new
        response.should redirect_to root_path
        flash[:notice].should == 'Vous devez etre connecté'
      end
    end
  end
end
