require 'spec_helper'

describe I18nOptionsHelper do
  describe "i18n_options" do
    before do
      stub(Constants::Sessions::Levels).all {["shu", "ha"]}
      stub(self).t('constants.sessions.levels.shu') {"learning"}
      stub(self).t('constants.sessions.levels.ha') {"perfectioning"}
    end
    it 'takes a class, an symbol, and map to [text, value]' do
      options = i18n_options(Constants::Sessions::Levels, :all)
      assert {options == [["learning", "shu"], ["perfectioning", "ha"]]}
    end
  end
end