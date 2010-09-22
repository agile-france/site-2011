#encoding: utf-8
require 'spec_helper'

describe SessionsController do
  include Devise::TestHelpers

  before do
    @cheese = Factory(:conference)
  end

  describe ', with a signed in user' do
    before do
      @john = Factory.create(:user)
      sign_in @john
    end

    describe ", GET /conferences/1/sessions/new" do
      before do
        @stilton = Factory(:session)
        stub(::Session).new { @stilton }
      end

      it "should be successful" do
        get :new, {:conference_id => @cheese.id}
        assigns(:session).should == @stilton
        response.should be_success
      end
    end

    describe ", POST /conferences/1/sessions" do
      before do
        @params = {:title => 'ancient', :description => 'and toxic'}
        post :create, :conference_id => @cheese.id, :session => @params
      end

      it ', should wire session to user and conference' do
        # XXX
        # at least, failed to spec it with mocks using rr+rspec+devise :)
        # devise current_user is not available in this spec ...
        ancient = ::Session.where(@params).first
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

    describe ', PUT /conferences/1/sessions/123' do
      def new_title
        'do not forget the donuts'
      end

      describe ', allows a user to update a session' do
        before do
          @session = Factory(:session, :conference => @cheese, :user => @john, :id => 123)
          put :update, {:conference_id => @cheese.id, :id => @session.id, :session => {:title => new_title}}
        end

        it 'should update session' do
          @session.reload.title.should == new_title
        end

        it 'should redirect to session' do
          response.should redirect_to('/conferences/1/sessions/123')
        end
      end

      describe ', does not authorize a user to modify other sessions' do
        before do
          @aaron = Factory(:user, :email => 'aaron@paterson.com')
          @nokogiri = Factory(:session, :user => @aaron, :id => 401, :title => 'nokogiri')
          request.env["HTTP_REFERER"] = conference_session_path(@cheese, @nokogiri)
          put :update, {:conference_id => @cheese.id, :id => @nokogiri.id, :session => {:title => new_title}}
        end

        it 'should not redirect to session' do
          response.should redirect_to('/conferences/1/sessions/401')
        end

        it 'should flash error' do
          flash[:error].should =~ /Pas autorisé/
        end
      end
    end
  end

  describe ', with a signed off user' do
    describe ", GET /conferences/1/sessions/new" do
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

  describe 'GET /conferences/1/sessions' do
    before do
      @vegetables = ['carrot'].map { |t| Factory(:session, :title => t) }
      @cheeses = ['stilton'].map { |t| @cheese.sessions.create(:title => t) }
    end

    it 'should show proposed sessions for a conference' do
      get :index, {:conference_id => @cheese.id}
      assigns(:sessions).should == @cheese.sessions
      response.should be_success
    end
  end

  # see http://github.com/rspec/rspec-rails/issues#issue/215
  # can not test a view using any helper_method in controller
  describe 'GET conferences/2/sessions/4' do
    render_views
    
    before do
      @kent = Factory(:user, :email => "kent@beck.org")
      @ron = Factory(:user, :email => "ron@jeffries.org")
      @xp = Factory(:conference, :name => 'xp', :id => 2)
      @explained = Factory(:session, :title => 'explained', :conference => @xp, :user => @kent, :id => 4)
    end

    describe ', with author logged in' do
      before do
        sign_in(@kent)
        get :show, :conference_id => @xp.to_param, :id => @explained.to_param
      end

      it 'should have an edit link' do
        assigns(:session).should == @explained
        response.should be_success
        response.body.should have_tag('a[href="/conferences/2/sessions/4/edit"]')
      end
    end

    describe ', with reader logged in' do
      before do
        sign_in(@ron)      
        get :show, :conference_id => @xp.to_param, :id => @explained.to_param
      end
    
      it 'should have an edit link' do
        assigns(:session).should == @explained
        response.should be_success
        response.body.should_not have_tag('a[href="/conferences/2/sessions/4/edit"]')
      end
    end    
  end
end