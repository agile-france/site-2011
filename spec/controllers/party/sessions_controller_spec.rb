#encoding: utf-8
require 'spec_helper'

describe Party::SessionsController do
  include Devise::TestHelpers

  before do
    @cheese = Factory(:conference)
  end

  describe ', with a signed in user' do
    before do
      @john = Factory.create(:user)
      sign_in @john
    end

    describe ", GET new" do
      before do
        @stilton = Factory(:session)
        stub(Party::Session).new {@stilton}
      end

      it "should be successful" do
        get :new, {:conference_id => @cheese.id}
        assigns(:session).should == @stilton
        response.should be_success
      end
    end

    describe ", POST create" do
      before do
        @params = {:title => 'ancient', :description => 'and toxic'}
        post :create, :conference_id => @cheese.id, :party_session => @params
      end

      it ', should wire session to user and conference' do
        # XXX
        # at least, failed to spec it with mocks using rr+rspec+devise :)
        # devise current_user is not available in this spec ...
        ancient = Party::Session.where(@params).first
        ancient.should_not be_nil
        ancient.conference.should == @cheese
        ancient.user.should == @john
      end

      it "should redirect to conference_path" do
        response.should redirect_to(conference_sessions_path(@cheese))
      end

      it "should flash success" do
        flash[:notice].should =~ /créée!/
      end
    end

  end

  describe ', with a signed off user' do
    describe ", GET new" do
      before do
        get :new, {:conference_id => @cheese.id}
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
      @vegetables = ['carrot'].map {|t| Factory(:session, :title => t) }
      @cheeses = ['stilton'].map {|t| @cheese.sessions.create(:title => t)}
    end

    it 'should show proposed sessions for a conference' do
      @cheese.sessions.should == @cheeses

      get :index, {:conference_id => @cheese.id}
      assigns(:sessions).should == @cheese.sessions
      response.should be_success
    end

  end
end
