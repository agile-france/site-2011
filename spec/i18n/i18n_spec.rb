require 'spec_helper'

describe 'i18n configuration' do
  it 'has fr default locale' do
    I18n.default_locale.should == :fr
  end
  
  it 'has fr locale' do
    I18n.locale.should == :fr
  end
  
  it 'should fallback to :en when translation is missing' do
    I18n.should respond_to(:fallbacks)
    I18n.fallbacks[:fr].should == [:fr, :en]
  end
  
  describe 'translate message' do
    before do
      I18n.backend.store_translations(:fr, {:cheese => 'fromage'})
      I18n.backend.store_translations(:en, {:choose => 'choose'})
    end
    
    it 'uses available :fr translation' do
      I18n.translate(:cheese).should == 'fromage'
    end
    
    it 'look for :en fallback translation' do
      I18n.translate(:choose).should == 'choose'
    end
    
    it 'raises when no translation' do
      I18n.translate(:goose).should == 'choose'
    end
  end
end
