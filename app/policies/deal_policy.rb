class DealPolicy < ApplicationPolicy
  def owner?
    user.deal_owner?(record)
  end

  def is_admin?
    user.admin?
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
