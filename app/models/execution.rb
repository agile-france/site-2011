class Execution
  include Mongoid::Document
  include Mongoid::Timestamps
  
  referenced_in :payer, :class_name => "User", :foreign_key => :payer_id, :inverse_of => :billings
  referenced_in :owner, :class_name => "User", :foreign_key => :owner_id, :inverse_of => :ownings
  referenced_in :product
  referenced_in :order
  
  # Public : Side of order B=bid or A=ask
  field :side, :default => Order::Side::BID
  validates_inclusion_of :side, :in => [Order::Side::BID, Order::Side::ASK]
  
  # Public : price
  field :price, :type => Float, :default => 0.0
  validates_numericality_of :price, :greater_than_or_equal_to => 0.0
  
  # Public : quantity
  field :quantity, :type => Integer, :default => 1
  validates_numericality_of :quantity, :greater_than_or_equal_to => 0, :only_integer => true
  
  # Public : reference of execution, used for clearing
  field :ref
  validates_length_of :ref, :maximum => 20
end