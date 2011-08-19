class Product
  include Mongoid::Document

  belongs_to :conference
  has_many :registrations

  # internal reference (acts as invoicing code)
  field :ref
  validates :ref, :presence => true, :uniqueness => true

  # what package or service this product confers (place, diner, ...)
  field :package
  # price at which this product can be bought
  field :price, type: Float
  # available quantity
  field :quantity, type: Integer
end
