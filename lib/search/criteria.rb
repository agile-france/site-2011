module Controllers
  module Search
    module Criteria
      def search(collection, hash_criteria)
        return collection.all if hash_criteria.empty?
        collection.where(regexpify(hash_criteria))
      end
      
      private
      def regexpify(hash_criteria)
        hash_criteria.reduce({}){|acc, (key, value)| acc[key] = (::Re.parse(value) || %r{#{value}}i); acc}
      end
    end
  end
end