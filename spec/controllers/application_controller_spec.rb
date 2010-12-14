require 'spec_helper'

describe ApplicationController do
  let(:xp) {Fabricate(:conference, :id => id(12))}
  
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
      controller.url_for(xp).should == "http://test.host/conferences/#{xp.id}?locale=en"
    end    
  end
end