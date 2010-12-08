module Controllers
  module Search
    module Criteria
      def search(collection, criteria)
        return collection.all if criteria.empty?
        collection.where(paternize!(criteria))
      end
      
      private
      def paternize!(criteria)
        criteria.each {|key, value| criteria[key] = (::Re.parse(value) || value)}
      end
    end
  end
end