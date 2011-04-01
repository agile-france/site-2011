class Conference
  include Mongoid::Document
  include Mongoid::Timestamps
  references_many :sessions
  references_many :products
  references_many :registrations
  referenced_in :owner, :class_name => "User", :foreign_key => :owner_id
  
  field :name
  field :edition
  attr_accessible :name, :edition
  key :name, :edition
  
  def emit!(ref, quantity, product, price)
    raise RuntimeError, "#{self.inspect} requires an owner to emit #{product.inspect}" if owner.blank?
    owner.sell(quantity, product, price, ref).tap(&:save)
  end
  
  # Public : new invoice for user, containing all user executions for this conference that are not invoiced
  def new_invoice_for(user)
    executions = products.map{|p| p.executions.select{|e| e.user == user && e.invoice.blank?}}.flatten
    Invoice.new.tap{|invoice| invoice.executions = executions}
  end  
end
