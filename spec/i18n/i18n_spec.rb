require 'spec_helper'

describe 'i18n configuration' do
  it 'has fr default locale' do
    I18n.default_locale.should == :fr
  end
  
  it 'should fallback to :en when translation is missing' do
    I18n.should respond_to(:fallbacks)
    I18n.fallbacks[:fr].should == [:fr, :en]
  end
    
end