class Ability
include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, :all
    can :update, Survey, :user_id => user.id, :live => false
  end
end
