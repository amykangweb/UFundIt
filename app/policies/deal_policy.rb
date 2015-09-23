class DealPolicy < ApplicationPolicy
  def owner?
    user.deal_owner?(record) || user.admin?
  end

  def is_admin?
    user.admin?
  end

  def can_edit?
    record.published? && !user.admin? ? false : true
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(published: true, private: false)
      end
    end
  end
end
