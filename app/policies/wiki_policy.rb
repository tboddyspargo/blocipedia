class WikiPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.try(:admin?)
        results = scope.all.order('created_at DESC')
      elsif user.try(:premium?)
        results = scope.includes(:collaborators).references(:collaborators).where("private != :yes or wikis.user_id = :user_id or collaborators.user_id = :user_id", yes: true, user_id: user.id).order('wikis.created_at DESC')
      elsif user.try(:standard?)
        results = scope.includes(:collaborators).references(:collaborators).where("private != :yes or collaborators.user_id = :user_id", yes: true, user_id: user.id).order('wikis.created_at DESC')
      else
        results = scope.where(private: false).order('created_at DESC')
      end
      results
    end
  end
  
  def index?
    true
  end
  
  def show?
    user.try(:admin?) or user == record.owner or record.collaborators.find_by(user_id: user.try(:id)) or record.public?
  end
  
  def new?
    create?
  end
  
  def create?
    not user.nil?
  end
  
  def destroy?
    user.try(:admin?) or user == record.owner
  end
  
  def edit?
    update?
  end
  
  def update?
    user.try(:admin?) or user == record.owner or record.collaborators.find_by(user_id: user.try(:id)) or record.public?
  end
end
