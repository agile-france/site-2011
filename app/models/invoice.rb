class Invoice
  include Mongoid::Document
  field :ref, :default => 'PENDING'
  validates_length_of :ref, :maximum => 20
  
  referenced_in :user
  references_many :executions
  
  attr_reader :amount, :lines
  def compute
    @amount, @lines = 0, {}
    executions.to_a.reduce([@amount, @lines]) do |acc, e|
      @amount += (e.quantity * e.price)
      if @lines[e.product]
        @lines[e.product][e.price] ? @lines[e.product][e.price] += e.quantity :
          @lines[e.product][e.price] = e.quantity
      else
        @lines[e.product] = {e.price => e.quantity}
      end
      acc  
    end
    self
  end
  
  def empty?
    amount ? amount == 0 : true
  end
end