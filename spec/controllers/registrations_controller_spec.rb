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


  describe "#assign, PUT /registrations/:registration_id/users/:user_id (INTEGRATION)" do
    # there are much more to stub than find ...
    # give up and use real model
    touch_db_with(:registration) {Fabricate(:registration)}
    touch_db_with(:ron) {Fabricate(:user, :email => 'ron@jeffri.es')}
    before do
      sign_in(john)
      put :assign, :registration_id => registration.id, :user_id => ron.id
    end

    specify {response.should redirect_to(registrations_account_path)}

    it "fills in relation (registration, user)" do
      registration.reload.user.should == ron
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

  describe "permissions" do
    let!(:mark) {Fabricate.build(:user, :email => 'mark@who.no')}
    let!(:admin) {Fabricate.build(:user, :email => 'ad@me.in', :admin => true)}
    let(:not_paid) {stub(:invoice => stub(:user => mark))}
    let(:paid) {stub(:invoice => stub(:user => john))}
    context "john" do
      before {controller.stubs(:current_user).returns(john)}
      it "can not assign a registration he did not paid" do
        assert {controller.cant?(:assign, not_paid)}
      end
      it "john can assign a registration he paid for" do
        deny {controller.cant?(:assign, paid)}
      end
    end
    context "admin" do
      before {controller.stubs(:current_user).returns(admin)}
      it "can assign any registration" do
        deny {controller.cant?(:assign, paid)}
        deny {controller.cant?(:assign, not_paid)}
      end
    end
  end
end