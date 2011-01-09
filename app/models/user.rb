class User
  include Mongoid::Document
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable

  field :first_name
  field :last_name
  field :bio
  field :avatar
  field :admin, :type => Boolean, :default => false
  
  # associations
  references_many :sessions
  referenced_in :company
  references_many :authentications
  
  # validations
  validates_inclusion_of :avatar, :in => ['gravatar'], :allow_nil => true
  
  # white list of accessible attributes
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :last_name, :bio

  # names are capitalized before validation
  before_validation do
    [:first_name, :last_name].each do |symbol|
      self.send(symbol).capitalize! if attribute_present? symbol
    end
  end

  # greeter_name is used to greet user
  def greeter_name
    return email if(first_name.blank? and last_name.blank?)
    "#{first_name} #{last_name}".strip
  end

  # propose a session to a conference
  # note this code saves only the Session model, as current storage enables it
  def propose(session, conference)
    session.tap do |s|
      s.user = self
      s.conference = conference
    end.save!
    self
  end
  
  # devise validatable hooks
  # password is not required if authenticated by external service
  def password_required?
    authentications.empty?? super : false
  end
end
