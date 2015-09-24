class DealsController < ApplicationController
  before_action :set_deal, only: [:commit, :show, :edit, :flag, :unflag, :update, :destroy]
  before_action :authenticate_user!, only: [:confirmation, :commit, :new, :edit, :update, :destroy]

  def confirmation
    @deal = Deal.find params[:deal_id]
  end

  def commit
    @deal.users << current_user
    flash[:notice] = "Committed!"
    redirect_to @deal
  end

  def index
    if params[:search]
      @deals = Deal.search(params[:search])
    else
      @deals = policy_scope Deal
    end
  end

  def show
    @comment = Comment.new
    @update = Update.new
  end

  def flag
    if @deal.flag
      flash[:notice] = "Thanks for the heads up. This listing has already been reported. An admin will review this listing to make sure it confirms with the Terms of Service."
      redirect_to root_path
    else
      @deal.flag = true
      @deal.save
      flash[:notice] = "Thanks for the heads up. An admin will review this listing to make sure it confirms with the Terms of Service."
      redirect_to root_path
    end
  end

  def unflag
    @deal.flag = false
    if @deal.save
      flash[:notice] = "Unflagged!"
      redirect_to root_path
    end
  end

  def new
    @deal = Deal.new
  end

  def edit
    authorize @deal, :owner?
    authorize @deal, :can_edit?
  end

  def create
    @deal = Deal.new(deal_params)
    @deal.owner_id = current_user.id
    respond_to do |format|
      if @deal.save
        format.html { redirect_to @deal, notice: 'Deal was successfully created.' }
        format.json { render :show, status: :created, location: @deal }
      else
        format.html { render :new }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      authorize @deal, :owner?
      authorize @deal, :can_edit?
      if @deal.update(deal_params)
        format.html { redirect_to @deal, notice: 'Deal was successfully updated.' }
        format.json { render :show, status: :ok, location: @deal }
      else
        format.html { render :edit }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @deal, :owner?
    authorize @deal, :can_edit?
    @deal.destroy
    respond_to do |format|
      format.html { redirect_to deals_url, notice: 'Deal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_deal
    @deal = Deal.find(params[:id])
  end

  def deal_params
    params.require(:deal).permit(:title, :image, :description, :goal, :location, :start, :end, :published, :private, :amount, :owner_id, :flag, :user_id => [])
  end
end
