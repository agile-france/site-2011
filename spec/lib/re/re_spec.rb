require 'spec_helper'
require 're/re'

describe Re do
  describe '#parse' do
    it "parses /hello/i" do
      re = Re.parse("/hello/i")
      assert {re.source == 'hello'}
      assert {re.options & Regexp::IGNORECASE == Regexp::IGNORECASE}
    end
    it "parses options //imx" do
      re = Re.parse("//imx")
      assert {re.options & Regexp::IGNORECASE == Regexp::IGNORECASE}
      assert {re.options & Regexp::MULTILINE == Regexp::MULTILINE}
      assert {re.options & Regexp::EXTENDED == Regexp::EXTENDED}
    end
    it "parses /cat/" do
      re = Re.parse("/cat/")
      assert {re.source == 'cat'}
    end
  end
end