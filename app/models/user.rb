class User
  include Mongoid::Document
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  field :first_name
  field :last_name
  field :bio
  field :admin, :type => Boolean, :default => false
  field :optins, :type => Array
  field :roles_in_company, :type => Array
  
  # associations
  references_many :authentications, :dependent => :destroy
  references_many :sessions, :dependent => :destroy
  references_many :orders, :dependant => :destroy
  referenced_in :company
  
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

  # Public : user propose a session to a conference
  #
  # returns true if session is saved, false otherwise, and then session contains validation errors
  #
  # note this code saves only the Session model, as current storage enables it
  def propose(session, conference)
    session.tap do |s|
      s.user = self
      s.conference = conference
    end.save
  end
  
  # devise validatable hooks
  # password is not required if authenticated by external service
  def password_required?
    authentications.empty?? super : false
  end
  
  # avatar returns 
  # - [:provider, url of image of the current authentication] if signed in using an authentication
  # - [:gravatar, gravatar url either]
  def avatar
    if (o = authentications.first and o.user_info)
      image = o.user_info['image']
      return [o.provider.to_sym, image] if image
    end
    [:gravatar, "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}"]
  end
  
  # generates a random password if blank
  def ensure_password_not_blank!
    self.password = Devise.friendly_token[0,20] if password.blank?
    self
  end
  
  # Public : respond true if user has opted in for given feature
  #
  # symbol_or_string - symbol or string representation for feature
  #
  # Examples :
  #   optin!(:sponsors)
  #
  #   optin?(:sponsors) => true
  #   optin?('sponsors') => true
  #
  def optin?(symbol_or_string)
    optins ? optins.any?{|optin| optin == symbol_or_string.to_s} : false
  end
  # Public : opts in for features and return self
  #
  # *optins - feature to accept, as string or symbol
  #
  # Examples :
  #   joe.optin!(:github, :disqus)
  #
  def optin!(*optins)
    optins.each do |optin|
      self.optins ||= []
      self.optins << optin.to_s unless self.optins.include?(optin.to_s)
    end
    self
  end

  # Public : rate session
  # updates user rating (there is one) or create new one
  def rate(session, rating_as_hash={})
    rating = session.ratings.where(:user_id => self.id).first
    rating ? rating.tap{|r| r.attributes=rating_as_hash} :
      Rating.new(rating_as_hash).tap do |rating|
        session.ratings << rating
        rating.user = self
      end
  end
  
  def buy(quantity, product, price, ref=nil)
    call(quantity, product, price, ref, Order::Side::BID)
  end
  
  def sell(quantity, product, price, ref=nil)
    call(quantity, product, price, ref, Order::Side::ASK)    
  end
  
  private
  def call(quantity, product, price, ref, side)
    Order.new(:user => self, :product => product, :price => price, :quantity => quantity, :ref => ref, :side => side)
  end

  # querying helpers
  class << self
    def identified_by_email(email)
      where(:email => email).first
    end
  end
end
