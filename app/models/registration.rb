class Registration
  include Mongoid::Document
  referenced_in :user
  referenced_in :product
  referenced_in :execution
  
  # Public : conference
  def conference
    product.conference
  end
  
  class << self
    def booked_for(conference)
      where(:product_id.in => conference.products.map{|p| p.id})
    end
    def booked_by(user)
      where(:execution_id.in => user.executions.map{|e| e.id})
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
      any_of([{:execution_id.in => user.executions.map{|e| e.id}}, {:user_id => user.id}])
    end
  end
end