# frozen_string_literal: true

class CollaboratorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.try(:admin?) or user.try(:premium?)
  end

  def destroy?
    wiki.owner == user
  end
end
