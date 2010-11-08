class Session
  include Mongoid::Document
  include Mongoid::Taggable
  tags_separator ' '
  
  referenced_in :conference, :inverse_of => :sessions
  referenced_in :user
  
  field :title
  field :description
  
  def tags_array=(tags_array)
    super(tags_array.sort)
  end
end
