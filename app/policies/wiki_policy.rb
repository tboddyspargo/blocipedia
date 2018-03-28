class WikiPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.try(:admin?)
        scope.all
      else
        scope.where("private != ? or user_id = ?", true, user && user.id)
      end
    end
  end
  
  def index?
    true
  end
  
  def show?
    user == record.user or not record.private
  end
  
  def create?
    user.exists?
  end
  
  def destroy?
    user.try(:admin?) or user == record.user
  end
  
  def update?
    user.try(:admin?) or user == record.user or not record.private
  end
  
  def edit?
    user.try(:admin?) or user == record.user or not record.private
  end
end
