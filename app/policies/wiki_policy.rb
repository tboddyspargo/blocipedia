class WikiPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.try(:admin?)
        results = scope.all
      else
        results = scope.where("private != ? or user_id = ?", true, user && user.id)
      end
      results.order('private DESC, created_at DESC')
    end
  end
  
  def index?
    true
  end
  
  def show?
    user.try(:admin?) or user == record.user or not record.private
  end
  
  def new?
    create?
  end
  
  def create?
    not user.nil?
  end
  
  def destroy?
    user.try(:admin?) or user == record.user
  end
  
  def edit?
    update?
  end
  
  def update?
    user.try(:admin?) or user == record.user or not record.private
  end
end
