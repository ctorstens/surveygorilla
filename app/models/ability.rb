class Ability
include CanCan::Ability

  def initialize(user)
    user ||= user.new
    can :read, :all
    can :update, Survey, :user_id => user.id
    # can :delete, Survey, 
  end
end
