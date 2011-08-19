class Registration
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user
  belongs_to :product
  belongs_to :invoice

  field :price, type: Float, default: 0.0
  field :ref

  # Public : conference
  def conference
    product.conference
  end

  class << self
    def booked_for(conference)
      where(:product_id.in => conference.products.map{|p| p.id})
    end
    def assigned_to(user)
      where(:user_id => user.id)
    end
    def unassigned
      where(:user_id.exists => false)
    end
    def assigned
      where(:user_id.exists => true)
    end
    # Public : any execution assigned to or booked by user
    def about(user)
      any_of([{:invoice_id.in => user.invoices.map{|e| e.id}}, {:user_id => user.id}])
    end
  end
end