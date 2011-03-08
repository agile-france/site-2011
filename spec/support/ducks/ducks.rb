module Ducks
  class << self
    def conference(attributes={})
      attributes = {:name => 'xp', :edition => 2012}.merge(attributes)
      Conference.new(attributes).tap{|c| c.products = self.products}
    end
    def products
      ['place', 'diner'].map {|ref| Product.new(:ref => ref).tap{|p| def p.orders; Ducks::orders(p); end}}
    end
    def orders(product)
      [[10, 1], [20, 10]].map {|price, quantity|
        Order.new(:price => price, :quantity => quantity, :product => product, :side => Order::Side::ASK)}
    end
  end
end