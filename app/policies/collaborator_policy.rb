class CollaboratorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  
  def create?
    user.try(premium?)
  end
  
  def destroy?
    self.wiki.owner == user
  end
  
end