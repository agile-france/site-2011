class Invoice
  include Mongoid::Document
  include Mongoid::Timestamps

  field :ref
  validates_length_of :ref, maximum: 20

  belongs_to :user
  has_many :executions, autosave: true

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

  def invoiceable?
    amount && amount > 0
  end
end