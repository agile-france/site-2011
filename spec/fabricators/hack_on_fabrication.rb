## hack on Fabrication, to accomodate with http://github.com/mongoid/mongoid/issues/395
require 'bson/types/object_id'
class Fabrication::Generator::Mongoid
  def process_attributes(attributes)
    super(cripple(attributes))
  end
  
  private
  def cripple(attributes)
    attributes.collect do |a|
      (a = a.dup).value = BSON::ObjectId(a.value) if a.name == :id
      a
    end
  end
end