module Mongo
  module IdHelper
    # make a valid Mongo::ObjectId out of an integer
    # id(12) # => "000000000000000000000012"
    def id(integer)
      integer.to_s.rjust(24, '0')
    end
  end
end

RSpec.configure do |configuration|
  configuration.include Mongo::IdHelper
  configuration.include Mongoid::Matchers
end