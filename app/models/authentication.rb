class Authentication
  include Mongoid::Document
  field :provider
  field :uid
  field :user_info, :type => Hash
  field :activated, :type => Boolean, :default => false
  
  referenced_in :user
  
  def deactivated?
    !activated?
  end
  
  def deactivate!(a=true)
    update_attributes!(:activated => !a)
  end
  
  class << self
    def activated?; __activated__is__(true); end
    def deactivated?; __activated__is__(false); end
    
    private
    def __activated__is__(a)
      criteria.where(:activated => a)
    end
  end
end