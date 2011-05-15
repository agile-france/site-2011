class Product
  include Mongoid::Document

  belongs_to :conference
  has_many :orders
  has_many :executions

  # internal reference
  field :ref
  validates :ref, :presence => true, :uniqueness => true
  # description
  field :description
  validates_length_of :description, :maximum => 120

  def offers
    Book.lines(Book[self].asks)
  end
end
