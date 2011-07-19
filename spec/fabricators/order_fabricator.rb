Fabricator(:order) do
  quantity 10
  price 220
end

Fabricator(:ask, :from => :order) do
  side Order::Side::ASK
end
Fabricator(:bid, :from => :order) do
  side Order::Side::BID
end
