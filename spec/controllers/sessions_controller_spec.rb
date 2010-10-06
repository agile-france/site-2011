#encoding: utf-8
require 'spec_helper'

describe SessionsController do
  before do
    @xp = Fabricate(:conference, :id => 1)
  end

  describe 'with a signed in user' do
    before do
      @john = Fabricate(:user)
      sign_in @john
    end

    describe "GET /conferences/1/sessions/new" do
      render_views
      
      before do
        @courage = Fabricate.build(:session)
        stub(::Session).new { @courage }
        get :new, {:conference_id => @xp.to_param}
      end

      it "should be successful" do
        get :new, {:conference_id => @xp.id}
        assigns(:session).should == @courage
        response.should be_success
      end
      
      it 'action should be POST to /conferences/1/sessions' do
        response.body.should have_tag('form[action="/conferences/1/sessions"]')
      end
    end

    describe "POST /conferences/1/sessions" do
      before do
        @params = {:title => 'courage', :description => 'and respect'}
        post :create, :conference_id => @xp.id, :session => @params
      end

      it 'should wire session to user and conference' do
        # XXX
        # at least, failed to spec it with mocks using rr+rspec+devise :)
        # devise current_user is not available in this spec ...
        ancient = ::Session.where(@params).first
        ancient.should_not be_nil
        ancient.conference.should == @xp
        ancient.user.should == @john
      end

      it "should redirect to session_path" do
        response.should redirect_to(@xp)
      end

      it "should flash success" do
        flash[:notice].should =~ /créée!/
      end
    end

    describe 'PUT /sessions/123' do
      def new_title
        'do not forget the donuts'
      end

      describe 'allows a user to update a session' do
        before do
          @simplicity = Fabricate(:session, :conference => @xp, :user => @john, :id => 123)
          put :update, {:conference_id => @xp.id, :id => @simplicity.id, 
            :session => {:title => new_title}}
        end

        it 'should update session' do
          @simplicity.reload.title.should == new_title
        end

        it 'should redirect to session' do
          response.should redirect_to('/sessions/123')
        end
      end

      describe 'does not authorize a user to modify other sessions' do
        before do
          @aaron = Fabricate(:user, :email => 'aaron@paterson.com')
          @nokogiri = Fabricate(:session, :user => @aaron, :id => 401, :title => 'nokogiri')
          request.env["HTTP_REFERER"] = session_path(@nokogiri)
          put :update, {:conference_id => @xp.id, :id => @nokogiri.id,
             :session => {:title => new_title}}
        end

        it 'should redirect to session' do
          response.should redirect_to('/sessions/401')
        end

        it 'should flash error' do
          flash[:error].should =~ /Pas autorisé/
        end
      end
    end
  end

  describe 'with a signed off user' do
    describe "GET /conferences/1/sessions/new" do
      before do
        get :new, {:conference_id => @xp.id}
      end
      it "should redirect user to sign_in url" do
        response.should redirect_to new_user_session_path
      end
      it "should have a flash alert" do
        flash[:alert].should_not be_nil
      end
    end
  end

  # see http://github.com/rspec/rspec-rails/issues#issue/215
  # can not test a view using any helper_method in controller
  describe 'GET /sessions/4' do
    render_views
    
    before do
      @kent = Fabricate(:user, :email => "kent@beck.org")
      @ron = Fabricate(:user, :email => "ron@jeffries.org")
      @xp = Fabricate(:conference, :name => 'xp', :id => 2)
      @explained = Fabricate(:session, :title => 'explained', :conference => @xp, :user => @kent, :id => 4)
    end

    describe 'for author' do
      before do
        sign_in(@kent)
        get :show, :conference_id => @xp.id, :id => @explained.id
      end

      it 'has a handy edit link' do
        assigns(:session).should == @explained
        response.should be_success
        response.body.should have_tag('a[href="/sessions/4/edit"]')
      end
    end

    describe 'for a reader' do
      before do
        sign_in(@ron)      
        get :show, :conference_id => @xp.id, :id => @explained.id
      end
    
      it 'has no edit link' do
        assigns(:session).should == @explained
        response.should be_success
        response.body.should_not have_tag('a[href="/sessions/4/edit"]')
      end
    end
    
    describe 'with "en" locale parameter' do
      before do
        get :show, :conference_id => @xp.id, :id => @explained.id, :locale => :en
      end
    
      it 'should have a link back to conference with "en" locale parameter' do
        response.body.should have_tag('a[href="/conferences/2?locale=en"]')
      end      
    end
  end
end