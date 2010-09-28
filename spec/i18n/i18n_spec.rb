require 'spec_helper'

describe 'i18n configuration' do    
  describe 'translate message in :fr' do
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
      lambda{I18n.translate(:goose)}.should raise_error I18n::MissingTranslationData
    end
  end
end
