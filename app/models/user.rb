class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name

  # names are capitalized
  before_validation do
    [:first_name, :last_name].each do |symbol|
      self.send(symbol).capitalize! if attribute_present? symbol
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
