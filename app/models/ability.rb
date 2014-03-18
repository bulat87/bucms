class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role == "admin"
      can :manage, :all
    elsif user.role == "reader"
      can :read, :all
      can :create, Comment
      can :delete, Comment do |comment|
        comment.try(:user) == user
      end
    end
  end
end