require 'nokogiri'
module NokogiriScraper
  def doc(content, &block)
    doc = Nokogiri::HTML(content)
    unless block.nil?
      self.instance_variable_set(:@doc, doc)
      class << self
        extend Forwardable
        def_delegators(:@doc, :at_xpath, :xpath, :at_css, :css)
      end
      return self.instance_eval(&block)
    end
    doc
  end
end

RSpec.configure do |configuration|
  configuration.include NokogiriScraper
end
