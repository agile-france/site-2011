require 'spec_helper'

describe Conference::SessionsController do
  describe "GET new" do
    it "should be successful" do
      get :new
      response.should be_success
    end
  end

  describe "POST create" do
    it "should be successful" do
      post :create
      response.should redirect_to root_path
    end
  end
end
