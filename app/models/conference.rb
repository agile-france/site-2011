class Conference
  include Mongoid::Document
  include Mongoid::Timestamps
  references_many :sessions
  references_many :products
  referenced_in :owner, :class_name => "User", :foreign_key => :owner_id
  
  field :name
  field :edition
  attr_accessible :name, :edition
  key :name, :edition
  
  def best_offers
    products.to_a.map{|p| p.best_offer}
  end
  
  def emit!(ref, quantity, product, price)
    raise RuntimeError, "#{self.inspect} requires an owner to emit #{product.inspect}" if owner.blank?
    owner.sell(quantity, product, price, ref).tap(&:save)
  end
end
