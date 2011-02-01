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
  
  describe "pager_options" do
    it 'is a hash with page option' do
      assert {controller.pager_options.is_a? Hash}
    end
    it 'params[:page] gives :page option' do
      assert {controller.pager_options[:page] == nil}
      controller.params[:page] = 1
      assert {controller.pager_options[:page] == 1}
    end
    it 'params[:per_page] gives :per_page option' do
      controller.params[:per_page] = 333
      assert {controller.pager_options[:per_page] == 333}
    end
    it 'params[:per_page] have default 25 value' do
      assert {controller.pager_options[:per_page] == 25}
    end
    it 'params[:per_page] have default value of klass.per_page, when method exists' do
      stub(Company).per_page {12}
      assert {controller.pager_options(Company)[:per_page] == 12}
    end    
  end
end