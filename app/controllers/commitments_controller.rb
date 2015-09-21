class CommitmentsController < ApplicationController
before # set user, set deal

  def new
    @commitment = Commitment.new(user_id: @user.id, deal_id: @deal.id, amount: @amount)
  end
end
