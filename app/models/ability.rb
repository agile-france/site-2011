class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    else
      can :manage, Session, user_id: user.id
      can :manage, Company, id: user.company_id

      [Session, Company].each do |c|
        can :read, c
      end

      can :vote, Session
      cannot :vote, Session, user_id: user.id
    end
  end
end