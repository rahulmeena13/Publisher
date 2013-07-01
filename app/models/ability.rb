class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    can :read, :all
    if user.role? :admin
      can :manage, :all
    elsif user.role? :editor      
      can :manage, Article
    elsif user.role? :reporter
      can :create, Article
      can :update, Article do |article|
        article.try(:user) == user || user.role?(:editor)
      end
      can :destroy, Article do |article|
        article.try(:user) == user || user.role?(:editor)
      end
    end

  end
end