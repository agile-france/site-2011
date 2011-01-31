module Constants  
  module Sessions
    module Levels
      def self.all; ["all", "shu", "ha", "ri"]; end
    end

    module Ages
      def self.all; ["exp", "new", "first", "old", "veryold"]; end
    end
    
    module Formats
      def self.all; ["rex", "workshop", "long_workshop", "talk", "keynote", "other"]; end
    end
  end
end
