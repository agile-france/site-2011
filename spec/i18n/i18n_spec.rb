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
    
    # I18n::MissingTranslationData on 1.9 and I18n::InvalidLocale with 1.8
    it 'raises a I18n:: error when no translation' do
      e = rescuing{I18n.translate(:goose)}
      assert {e.is_a? StandardError and e.class.name =~ /^I18n::(.+)$/}
    end
  end
end
