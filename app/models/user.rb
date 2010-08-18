class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name


  has_many :sessions

  # names are capitalized before validation
  before_validation do
    [:first_name, :last_name].each do |symbol|
      self.send(symbol).capitalize! if attribute_present? symbol
    end
  end

  def greeter_name
    return email if(first_name.nil? and last_name.nil?)
    "#{first_name} #{last_name}".strip
  end
end
