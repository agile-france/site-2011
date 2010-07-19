#encoding: utf-8
require 'spec_helper'
#require 'i18n'

describe "home/index.html.haml" do
  describe ', with fr locale' do
    before do
 #     I18n.default_locale = :fr
      render
    end

    it 'should have h1. Conférence Agile France' do
      rendered.should have_tag('h3') do |h3|
        h3.should contain 'Conférence Agile France'
      end
    end
  end
end
