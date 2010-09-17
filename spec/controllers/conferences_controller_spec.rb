#encoding: utf-8
require 'spec_helper'

describe ConferencesController do
  describe ', self' do
    it 'should know about conference_path' do
      ConferencesController.new.should respond_to(:conference_path)
    end
  end

  describe "GET 'show'" do
    describe ', with existing conference params' do
      before do
        @deep = Factory(:conference, {:name => 'deep', :edition => '2011'})
      end

      it "should be successful for an existing party" do
        get :show, {:id => @deep.id}
        response.should be_success
      end
    end

    describe ', with flunky party parameters' do
      before do
        get :show, {:id => 42}
      end

      it 'should redirect to root_path' do
        response.should redirect_to root_path
      end

      it 'should flash ya' do
        flash[:error].should_not be_nil
      end
    end
  end

  describe 'index' do
    before do
      # XXX weird isolation there :)
      # what use is use_transactional_fixtures ??
      Conference.delete_all unless Conference.all.empty?
    end

    it 'should show available conferences' do
      conferences = (2030..2032).map {|edition| Factory(:conference, :name => 'deep', :edition => edition)}
      get :index
      assigns(:conferences).should == conferences
      response.should be_success
    end
  end
end
