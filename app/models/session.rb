class Session
  def self.capacity; (10..50); end

  include Mongoid::Document
  include Mongoid::Taggable
  include Mongoid::Timestamps

  referenced_in :conference
  referenced_in :user
  embeds_many :ratings

  field :title
  field :description
  field :format
  field :capacity, :type => Integer
  field :level
  field :age

  attr_accessible :title, :description, :format, :capacity, :level, :age
  attr_accessible :tags

  validates_each :capacity do |model,attr,value|
    unless value.nil? or Session.capacity.include?(value)
      model.errors.add(attr, I18n.translate('sessions.errors.capacity', :range => Session.capacity))
    end
  end
  validates :title, :presence => true, :length => { :maximum => 150 }

  # Public: mean of stars for all reviews
  def stars
    rated?? (self.ratings.reduce(0.0){|stars, r| stars = stars + r.stars}) / self.ratings.size : 0
  end
  # Public : has this session been rated ?
  def rated?
    not self.ratings.empty?
  end
end
