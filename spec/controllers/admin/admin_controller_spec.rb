require 'spec_helper'

describe Admin::AdminController do
  context 'when not logged' do
    before do
      get :show
    end
    it 'redirects to sign in path' do
      response.should redirect_to(new_user_session_path)
    end
  end
  
  context "when signed in as a user" do
    touch_db_with(:user) {Fabricate(:user)}
    before do
      sign_in(user)
      get :show
    end
    it 'redirects to conferences_path' do
      response.should redirect_to(root_path)
    end
  end
end
