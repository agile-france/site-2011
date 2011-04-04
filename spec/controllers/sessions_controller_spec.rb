#encoding: utf-8
require 'spec_helper'

describe SessionsController do
  touch_db_with(:xp) {Fabricate(:conference)}
  touch_db_with(:john) {Fabricate(:user)}
  
  describe 'with a signed in user' do
    before do
      sign_in john
    end

    describe "GET /conferences/:conference_id/sessions/new" do
      render_views
      touch_db_with(:courage) {Fabricate(:session)}
      
      before do
        get :new, {:conference_id => xp.to_param}
      end
      
      it 'new_conference_session_path should be /conferences/:conference_id/sessions/new' do
        assert {new_conference_session_path(xp) == "/conferences/#{@xp.id}/sessions/new"}
      end
      
      it "should be successful" do
        get :new, {:conference_id => xp.id}
        response.should be_success
      end
      
      it 'action should be POST to /conferences/:conference_id/sessions' do
        response.body.should have_tag("form[action=\"/conferences/#{@xp.id}/sessions\"]")
      end
    end

    describe "POST /conferences/:id/sessions" do
      context "successful" do
        # XXX integration POST testing of multiple behaviors
        before do
          @params = {:title => 'courage', :description => 'and respect'}
          post :create, :conference_id => @xp.id, :session => @params.merge(:tags => 'courage, respect')
        end

        it 'should redirect to session_path, wire session to user and conference, flash' do
          # XXX
          # at least, failed to spec it with mocks using rr+rspec+devise :)
          # devise current_user is not available in this spec ...
          session = ::Session.where(@params).first
          session.should_not be_nil
          session.conference.should == xp
          session.user.should == john
          assert {session.tags_array.include? 'courage'}

          response.should redirect_to(xp)

          flash[:notice].should =~ /créée!/
        end        
      end
      
      context "validation fails" do
        before do
          @params = {:title => 'courage', :description => 'and respect', :capacity => '123'}
          post :create, :conference_id => xp.id, :session => @params
          s = @controller.send(:current_session)
          deny {s.valid?}          
        end
        it 'show errors on current page' do
          response.should be_success
        end
      end
    end

    describe 'PUT /sessions/:id' do
      def new_title
        'do not forget the donuts'
      end

      describe 'allows a user to update a session' do
        touch_db_with(:simplicity) {Fabricate(:session, :conference => xp, :user => john)}
        before do
          put :update, {:id => simplicity.id, :session => {:title => new_title}}
        end

        it 'redirect to session, should update session' do
          simplicity.reload.title.should == new_title
          response.should redirect_to(awesome_session_path(@simplicity))
        end
      end

      describe 'does not authorize a user to modify other sessions' do
        touch_db_with(:aaron) {Fabricate(:user, :email => 'aaron@paterson.com')}
        touch_db_with(:nokogiri) {Fabricate(:session, :user => @aaron, :title => 'nokogiri')}
                
        before do
          request.env["HTTP_REFERER"] = awesome_session_path(nokogiri)
          put :update, {:id => nokogiri.id, :session => {:title => new_title}}
        end

        it 'should redirect to session with flash' do
          response.should redirect_to(awesome_session_path(nokogiri))
          flash[:error].should =~ /Pas autorisé/
        end
      end
      
      describe 'DELETE' do
        touch_db_with(:simplicity) {Fabricate(:session, :conference => xp, :user => john)}
        
        before do
          delete :destroy, :id => simplicity.id
        end
        it 'redirects to account sessions, and destroys aforementioned session' do
          response.should redirect_to(sessions_account_path)
          assert {::Session.criteria.for_ids(@simplicity.id).empty?}
        end
      end
    end
  end

  describe 'with a signed off user' do
    describe "GET /conferences/:conference_id/sessions/new" do
      before do
        get :new, {:conference_id => xp.id}
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
    
    touch_db_with(:kent) {Fabricate(:user, :email => "kent@beck.org")}
    touch_db_with(:ron) {Fabricate(:user, :email => "ron@jeffries.org")}
    touch_db_with(:explained) {Fabricate(:session, :title => 'explained', :conference => @xp, :user => @kent, :id => id(4))}

    describe 'for author' do
      before do
        sign_in(@kent)
        get :show, :id => @explained.id
      end

      it 'has a handy edit link' do
        assigns(:session).should == @explained
        response.should be_success
        response.body.should have_tag("a[href=\"/sessions/#{id(4)}/edit\"]")
      end
    end

    describe 'for a reader' do
      before do
        sign_in(@ron)
        [2,2,3].each {|stars| explained.ratings.create(:stars => stars)}
        get :show, :id => @explained.id
      end
    
      it 'has no edit link' do
        assigns(:session).should == @explained
        response.should be_success
        response.body.should_not have_tag(edit_awesome_session_path(@explained))
      end
      it 'mean vote is truncated to 2 digits' do
        response.body.should =~ /^Moyenne : 2.33$/
      end
    end
    
    describe 'with "en" locale parameter' do
      before do
        get :show, :id => @explained.id, :locale => :en
      end
    
      it 'should have a link back to conference with "en" locale parameter' do
        response.body.should have_tag("a[href=\"/conferences/#{@xp.id}?locale=en\"]")
      end      
    end
  end
end