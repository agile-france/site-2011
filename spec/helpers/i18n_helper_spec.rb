require 'spec_helper'

describe I18nHelper do
  describe "i18n_options_for" do
    before do
      Constants::Sessions::Levels.stubs(:all).returns(["shu", "ha"])
      self.stubs(:t).with('constants.sessions.levels.shu').returns("learning")
      self.stubs(:t).with('constants.sessions.levels.ha').returns("perfectioning")
    end
    it 'takes a class, an symbol, and map to [text, value]' do
      options = i18n_options_for(Constants::Sessions::Levels, :all)
      assert {options == [["learning", "shu"], ["perfectioning", "ha"]]}
    end
  end
  
  describe "i18n_text_for" do
    let(:session) {Fabricate(:session, :level => "shu")}
    before do
      self.stubs(:t).with('constants.sessions.levels.shu').returns("learning")
    end
    it "gets text for a resource, a field with a conventional inference" do
      text = i18n_text_for(session, :level)
      assert {text == "learning"}
    end
  end
end