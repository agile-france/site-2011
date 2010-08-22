#encoding: utf-8
require 'spec_helper'
require 'i18n'

describe "home/index.html.haml" do
  describe ', with fr locale' do
    before do
      I18n.locale = :fr
      render
    end

    it 'should have h3. Conférence Agile France' do
      rendered.should have_tag('h3', :content => 'Conférence')
    end

    it 'should have a link Proposer une session' do
      rendered.should have_tag('a', :href => '/sessions/new', :content => 'Proposer une session')
    end
  end

  describe ', with en locale' do
    before do
      I18n.locale = :en
      render
    end

    it 'should have h3. Agile France Conference' do
      rendered.should have_tag('h3', :content => 'Conference')
    end
  end
end
