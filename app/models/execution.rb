class Execution
  include Mongoid::Document
  include Mongoid::Timestamps
  
  referenced_in :user
  referenced_in :product
  referenced_in :order
  # execution linking
  referenced_in :matchee, :class_name => "Execution", :foreign_key => :matchee_id, :inverse_of => :matchee
  # named registrations for ordered product
  references_many :registrations, :autosave => true, :dependent => :destroy
  # invoice
  referenced_in :invoice
  
  # Public : Side of order B=bid or A=ask
  field :side, :default => Order::Side::BID
  validates_inclusion_of :side, :in => [Order::Side::BID, Order::Side::ASK]
  
  # Public : price
  field :price, :type => Float, :default => 0.0
  validates_numericality_of :price, :greater_than_or_equal_to => 0.0
  
  # Public : quantity
  field :quantity, :type => Integer, :default => 1
  validates_numericality_of :quantity, :greater_than_or_equal_to => 0, :only_integer => true

  # Public : amount of this execution, quantity * price
  def amount
    quantity * price
  end
  # Public : match_with
  def match_with(matchee)
    self.matchee = matchee
    matchee.matchee = self
    self
  end
  # Public : registers a user to product, if there are registrations left and user is not registered yet
  def registers(user, product)
    if(registrations.size < quantity and not user.registered_to?(product))
      user.registrations.build(:product => product, :execution => self) 
    end
  end
  # Public : build quantity registations for product
  def build_registrations!
    quantity.times.map{registrations.build(:product => product)}
  end
  # Public : conference
  def conference
    product.conference
  end
  
  class << self
    def booked_for(conference)
      where(:product_id.in => conference.products.map{|p| p.id})
    end
    def booked_by(user)
      where(:user_id => user.id)
    end
  end
end