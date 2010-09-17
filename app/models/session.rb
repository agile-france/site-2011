class Session < ActiveRecord::Base
  belongs_to :user, :class_name => 'User'
  belongs_to :conference
end
