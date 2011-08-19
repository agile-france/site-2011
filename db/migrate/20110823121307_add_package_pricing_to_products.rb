class AddPackagePricingToProducts < Mongoid::Migration
  def self.up
    Product.destroy_all

    agf11 = Conference.first
    products_by_price = [['FR', 0.0], ['1D', 135.0], ['EA', 220.0], ['', 270.0], ['DI', 40.0]].reduce({}) do |acc, (ref, price)|
      acc[price] = Product.create(ref: "AGF11#{ref}", price: price, conference: agf11, package: ref == 'DI' ? 'diner' : 'place')
      acc
    end

    Registration.all.each do |r|
      r.product = products_by_price[r.price]
      r.ref = r.product.ref
      r.save
      say "registration updated : #{r.inspect}"
    end
  end

  def self.down
  end
end