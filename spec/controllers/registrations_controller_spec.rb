#encoding: utf-8
require 'spec_helper'

describe RegistrationsController do
  # what a pain ! conference_path(xp) raises when conference is not persisted ...
  # stub(xp).persisted? {true} and stub(xp).new_record? {false} are not enough to change behavior :(
  #
  touch_db_with(:place) {Fabricate(:product)}
  touch_db_with(:xp_dot_org) {Fabricate(:user, :email => 'conf@xp.org')}
  touch_db_with(:xp) {Fabricate(:conference, :owner => xp_dot_org)}
  before do
    xp.emit!('CHEAP', 10, place, 220)
  end
  
  describe "registering through POST /conference/:conference_id/registrations" do
    touch_db_with(:john) {Fabricate(:user)}
    before do
      sign_in(john)
      order = xp.best_offers.first
      post :create, :conference_id => xp.id,
        :orders => [{:product_id => place.id, :quantity => 1, :price => 220, :checked => true}]
    end
    # XXX integration POST testing of multiple behaviors
    it "redirects to conference page, notice successful registration, saves john order for conference place" do
      response.should redirect_to(registrations_account_path)
      assert {flash[:notice] =~ /enregistrée/}
      assert {john.orders.where(:product_id => place.id).count == 1}
    end
  end
  
  context "user is unsigned" do
    describe "GET registration form" do
      it "ask him to sign in" do
        get :new, :conference_id => xp.id
        response.should redirect_to(new_user_session_path)
      end      
    end
    describe "POST registration" do
      it "ask him to sign in" do
        post :create, :conference_id => xp.id
        response.should redirect_to(new_user_session_path)
      end      
    end
  end
end