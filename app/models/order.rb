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
  referenced_in :user
  referenced_in :product
  
  # Public : Side of order B=bid or A=ask
  field :side, :default => Side::BID
  validates_inclusion_of :side, :in => [Side::BID, Side::ASK]
  
  # Public : price
  field :price, :type => Float, :default => 0.0
  validates_numericality_of :price, :greater_than_or_equal_to => 0.0
  
  # Public : quantity
  field :quantity, :type => Integer, :default => 1
  validates_numericality_of :quantity, :greater_than_or_equal_to => 0, :only_integer => true
  
  # Public : ref
  field :ref
  validates_length_of :ref, :maximum => 20
  
  def ask?; side == Side::ASK; end
  def bid?; side == Side::BID; end
  
  def remaining_quantity
    quantity
  end
end