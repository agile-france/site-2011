#encoding: utf-8
require 'spec_helper'

describe RegistrationsController do
  # what a pain ! conference_path(xp) raises when conference is not persisted ...
  # stub(xp).persisted? {true} and stub(xp).new_record? {false} are not enough to change behavior :(
  #
  let!(:place) {Fabricate(:product)}
  let!(:xp_dot_org) {Fabricate(:user, :email => 'conf@xp.org')}
  let!(:xp) {Fabricate(:conference, :owner => xp_dot_org)}
  before do
    xp.emit!('CHEAP', 10, place, 220)
  end
  
  describe "registering through POST /conference/:conference_id/registrations" do
    let(:john) {Fabricate(:user)}
    before do
      sign_in(john)
      order = xp.best_offers.first
      post :create, :conference_id => xp.id,
        :orders => [{:product_id => place.id, :quantity => 1, :price => 220, :checked => true}]
    end
    it "redirects to conference page" do
      response.should redirect_to(conference_path(xp))
    end
    it "user notice successful registration" do
      assert {flash[:notice] =~ /enregistrée/}
    end
    it "saves john order for conference place" do
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