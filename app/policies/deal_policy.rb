class DealPolicy < ApplicationPolicy
  def owner?
    user.deal_owner?(record)
  end
end
