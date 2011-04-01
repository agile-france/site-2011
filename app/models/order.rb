class Order
  class Side
    BID = 'B'
    ASK = 'A'
    def self.opposite(side)
      case side
      when BID; ASK
      when ASK; BID
      end
    end
  end
  
  include Mongoid::Document
  include Mongoid::Timestamps
  
  referenced_in :user
  referenced_in :product
  references_many :executions
  
  # Public : Side of order B=bid or A=ask
  field :side, :default => Side::BID
  validates_inclusion_of :side, :in => [Side::BID, Side::ASK]
  
  # Public : price
  field :price, :type => Float, :default => 0.0
  validates_numericality_of :price, :greater_than_or_equal_to => 0.0
  
  # Public : quantity
  field :quantity, :type => Integer, :default => 1
  validates_numericality_of :quantity, :greater_than_or_equal_to => 0, :only_integer => true
  
  # Public : reference of order, used for clearing
  field :ref
  validates_length_of :ref, :maximum => 20
  
  def ask?; side == Side::ASK; end
  def bid?; side == Side::BID; end
  
  # Public : executed quantity
  def executed
    executions.reduce(0){|acc, e| acc += e.quantity}
  end
  
  # Public : remaining quantity of order is quantity mminus executed quantity
  def remaining
    quantity - executed
  end
  
  # Public : returns whether self can match against other
  def matches?(other)
    return false unless other
    return false if side == other.side
    return false if filled?
    return true if [self, other].any?{|o| o.priceless?}
    bid?? price >= other.price : price <= other.price
  end  
  
  # Public : active order is not filled
  def active?
    not filled?
  end
  # Public : has execution but not filled
  def partially_filled?
    executed > 0 and executed < quantity
  end
  # Public : is filled ?
  def filled?
    executed >= quantity    
  end
  # Public : add execution for self at given quantity and price
  def fill!(q = self.quantity, p = self.price)
    executions.build(:user => user, :product => product, :side => side, :quantity => q, :price => p, :ref => ref)
  end
  # Public : has price
  def priceless?
    price == 0
  end

  class << self
    def opposite(order)
      order.dup.tap{|o| o.side = Side.opposite(order.side)}
    end    
  end
end