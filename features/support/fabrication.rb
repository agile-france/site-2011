module FabricationHelper
  def crippled(hash)
    hash.symbolize_keys
  end
end
World(FabricationHelper)

module ConferenceHelper
  def current_conference
    @current_conference ||= (Conference.first || Fabricate(:conference))
  end
end
World(ConferenceHelper)

Fabrication::Support.find_definitions
Fabrication::Fabricator.schematics.each_key do |symbol|
  Given /^the following (?:#{symbol}|#{symbol.to_s.pluralize}) exist(?:s):$/ do |table|
    table.hashes.each do |hash|
      Fabricate(symbol, crippled(hash))
    end
  end
end