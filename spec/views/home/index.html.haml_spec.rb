#encoding: utf-8
require 'spec_helper'
require 'i18n'

describe "home/index.html.haml" do
  describe ', with fr locale' do
    before do
      I18n.locale = :fr
      render
    end

    it 'should have h1. Conférence Agile France' do
      rendered.should have_tag('h3') do |h3|
        h3.should contain 'Conférence Agile France'
      end
    end
  end

  describe ', with en locale' do
    before do
      I18n.locale = :en
      render
    end

    it 'should have h1. Conference Agile France' do
      rendered.should have_tag('h3') do |h3|
        h3.should contain 'Agile France Conference'
      end
    end
  end
end
