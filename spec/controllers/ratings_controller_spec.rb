require 'spec_helper'

describe RatingsController do
  context "john signed in" do
    touch_db_with(:john) {Fabricate(:user)}
    touch_db_with(:mark) {Fabricate(:user, :email => 'mark@mail.com')}
    touch_db_with(:explained) {Fabricate(:session, :user => mark)}
    before do
      sign_in(john)
    end

    describe "can vote for mark session (POST /sessions/:awesome_session_id/ratings)" do
      before do
        post :create, :awesome_session_id => explained.id, :rating => {:stars => "5"}
      end
      it 'redirects to session' do
        response.should redirect_to(awesome_session_path(explained))
      end
      it 'adds rating for current user' do
        explained.reload
        assert {explained.ratings.first.stars == 5}
      end
    end

    describe "can update its vote (PUT /sessions/:awesome_session_id/ratings/:id)" do
      before do
        [mark, john].each{|u| u.rate(explained, :stars => 5).save}
        id = explained.ratings.last.id
        put :update, :awesome_session_id => explained.id, :id => id, :rating => {:stars => "1"}
      end
      it 'redirects to session' do
        response.should redirect_to(awesome_session_path(explained))
      end
      it 'updates rating for current user' do
        explained.reload
        assert {explained.stars == 3}
      end
    end
  end
end