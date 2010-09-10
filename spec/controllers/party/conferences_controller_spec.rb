#encoding: utf-8
require 'spec_helper'

describe Party::ConferencesController do
  describe "GET 'show'" do
    before do
      @deep = {:name => 'deep', :edition => '2011'}
      Factory(:conference, @deep)
    end

    it "should be successful for an existing party" do
      get :show, @deep
      response.should be_success
    end

    describe ', with flunky party parameters' do
      before do
        get :show, {:name => 'space', :edition => '2001'}
      end

      it 'should redirect to root_path' do
        response.should redirect_to root_path
      end

      it 'should flash ya' do
        flash[:notice].should =~ /Aucun\(e\) (?:.*)Conference/
      end
    end
  end
end
