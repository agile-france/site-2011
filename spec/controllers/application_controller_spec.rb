require 'spec_helper'

describe ApplicationController do
  before do
    @xp = Fabricate(:conference, :id => id(12))
  end
    
  describe 'default url options' do
    it 'are default empty' do
      controller.default_url_options.should == {}
    end
    
    it 'gains locale when present in session' do
      session[:locale] = :en
      controller.default_url_options.should == {:locale  =>  :en}
    end
  end
  
  describe 'url helper for' do
    it 'appends locale parameter when present' do
      session[:locale] = :en
      controller.url_for(@xp).should == "http://test.host/conferences/#{id(12)}?locale=en"
    end    
  end
end