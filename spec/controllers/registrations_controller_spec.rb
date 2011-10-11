#encoding: utf-8
require 'spec_helper'

describe RegistrationsController do
  # what a pain ! conference_path(xp) raises when conference is not persisted ...
  # stub(xp).persisted? {true} and stub(xp).new_record? {false} are not enough to change behavior :(
  #
  touch_db_with(:xp) {Fabricate(:conference)}
  touch_db_with(:place) {Fabricate(:product, :conference => xp)}
  touch_db_with(:john) {Fabricate(:user)}

  describe "registering through POST /conference/:conference_id/registrations" do
    before do
      sign_in(john)
    end
    describe "POST a quantiy of 10" do
      it "is not implemented !!!" do
        post :create, :conference_id => xp.id,
          :orders => [{:product_id => place.id, :quantity => 10, :price => 220}]
        assert {response.status == 503}
      end
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

  describe "search (INTEGRATION)" do
    render_views
    before(:all) do
      User.destroy_all
      @yuma = ['yuma', 'uma', 'numa', 'amu'].map {|s|
        Fabricate(:user, :first_name => s, :email => "#{s}@li.com")
      }.first
      @registration = Registration.create(:user => @yuma, :product => place)
    end
    context "no query params" do
      before do
        sign_in(@yuma)
        get :search, :id => @registration.id, :q => 'um', :format => :js
      end
      subject {assigns(:users)}
      ['uma', 'numa'].each do |name|
        it {assert {subject.any?{|u| u.first_name =~ %r{#{name}}i}}}
      end
    end
  end
end