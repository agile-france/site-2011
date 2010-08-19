class Conference < ActiveRecord::Base
  has_many :sessions
end
