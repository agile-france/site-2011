class Book
  attr_reader :book
  private :book
  
  def initialize(orders=[])
    @book = [RBTree.new.readjust{|a,b| b <=> a}, RBTree.new]
    orders.reduce(@book) do |acc, o|
      accept(o)
      acc
    end
  end
  
  def bids; book.first; end
  def asks; book.second; end
  
  # Public : accept o in book
  # returns a list made of o and orders that matched against
  def accept(o)
    list = [o]
    while(best = best(opposite_page(o)) and o.matches?(best))
      ### XXX should be wrapped in a transaction ...
      quantity = [o.remaining, best.remaining].min
      executions = [o, best].map{|order| order.fill!(quantity, best.price)}
      unpark(best) if best.filled?
      list << best 
      list.concat(executions)
    end
    park(o) unless o.filled?
    list
  end
  
  def best(page)
    _k, v = page.first
    return v.first if v
    nil
  end
  
  private
  def park(o)
    (same_page(o)[o.price] ||= []) << o
  end
  def unpark(o)
    page = same_page(o)
    list = page[o.price].tap{|list| list.delete(o)}
    page.delete(o.price) if list.empty?
  end
  def opposite_page(o)
    o.bid?? asks : bids
  end
  def same_page(o)
    o.bid?? bids : asks
  end
  
  class_attribute :books
  self.books = {}
  class << self
    def [](product)
      books[product.id] ||= Book.new(product.orders)
    end
  end
end
