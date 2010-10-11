module FabricationHelper
  def crippled(hash)
    hash.symbolize_keys
  end
end

World(FabricationHelper)

Fabrication::Support.find_definitions
Fabrication::Fabricator.schematics.each_key do |symbol|
  Given /^the following (?:#{symbol}|#{symbol.to_s.pluralize}) exist(?:s):$/ do |table|
    table.hashes.each do |hash|
      Fabricate(symbol, crippled(hash))
    end
  end
end