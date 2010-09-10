class Party::Conference < ActiveRecord::Base
  has_many :sessions
end
