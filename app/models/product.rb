class Product
  include Mongoid::Document
  referenced_in :conference
  references_many :orders
  references_many :executions

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
