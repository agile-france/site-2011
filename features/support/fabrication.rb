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
      Fabricate(symbol, hash.symbolize_keys)
    end
  end
end