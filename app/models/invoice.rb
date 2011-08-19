class Invoice
  include Mongoid::Document
  include Mongoid::Timestamps
  mount_uploader :pdf, PdfUploader

  field :ref
  validates_length_of :ref, maximum: 20

  belongs_to :user
  belongs_to :conference
  has_many :registrations, autosave: true

  def amount
    compute unless @amount
    @amount
  end

  def lines
    compute unless @lines
    @lines
  end

  def invoiceable?
    amount > 0
  end

  private
  def compute
    @amount, @lines = 0, {}
    registrations.to_a.reduce([@amount, @lines]) do |acc, e|
      @amount += e.price
      if @lines[e.product]
        @lines[e.product][e.price] ? @lines[e.product][e.price] += 1 :
          @lines[e.product][e.price] = 1
      else
        @lines[e.product] = {e.price => 1}
      end
      acc
    end
    self
  end

  class << self
    def for(conference)
      where(conference_id: conference.id)
    end
    def payed_by(user)
      where(:user_id => user.id)
    end
  end
end