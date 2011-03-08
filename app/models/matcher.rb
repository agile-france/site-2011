class Matcher
  def opposite(order)
    order.dup.tap{|o| o.side == Order::Side.opposite(order.side)}
  end
end