class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @deals = @user.owned_deals.paginate(page: params[:page], per_page: 10)
    @committed = @user.deals.paginate(page: params[:page], per_page: 10)
  end
end
