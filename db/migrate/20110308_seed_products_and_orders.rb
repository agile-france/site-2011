class SeedProductsAndOrders < Mongoid::Migration
  def self.up
    conference = seed_owner(Conference.first)
    data = [
      ['place', [['AGF11E', 100, 220], ['AGF11S', 140, 270]]],
      ['diner', [['AGF11D',60, 40]]]
    ]
    orders = seed_orders(conference, seed_products(conference, data))
    puts "=> built following orders\n"
    require 'pp'; pp orders
  end

  def self.down
    c = Conference.first
    puts "dropping products from #{c}"
    c.products.destroy_all
    c.tap{|c| c.owner = nil; c.save!}
    owner = User.identified_by_email('orga@conf.agile-france.org')
    owner.orders.destroy_all
    owner.destroy
  end
  
  private
  class << self
    def seed_owner(conference)
      puts "seeding owner for #{conference.inspect}"
      email = 'orga@conf.agile-france.org'
      owner = User.identified_by_email(email) ||
        User.new(:email => email).tap{|o| o.ensure_password_not_blank!; o.save!}
      conference.tap{|c| c.owner = owner; c.save!}
    end
  
    def seed_products(conference, data)
      puts "seeding products for #{conference.inspect} with #{data}"    
      data.map do |ref, *tail|
        [Product.create(:ref => ref, :conference => conference), *tail]
      end      
    end
    
    def seed_orders(conference, data)
      puts "seeding products for #{conference.inspect} with #{data}"    
      data.map do |product, orders|
        orders.map do |ref, q, p|
          conference.emit!(ref, q, product, p)
        end
      end  
    end
  end
end