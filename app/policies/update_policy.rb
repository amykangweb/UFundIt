class UpdatePolicy < ApplicationPolicy
  def owner?
    user.update_owner?(record)
  end
end
