class Ability
  include CanCan::Ability

  def initialize(cast)
    if cast.admin?
      can :manage, :all
    else
      can :read, :all
      can [:edit, :update], Cast, id: cast.id
    end
  end
end