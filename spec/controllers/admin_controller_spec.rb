require 'spec_helper'

describe AdminController do

  describe "GET 'show'" do
    let :simple_user
    it "should redirect to back" do
      request.env["HTTP_REFERER"] = root_path
      get :show
      response.should redirect_to(root_path)
    end
  end
end
