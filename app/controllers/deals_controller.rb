class DealsController < ApplicationController
  before_action :set_deal, only: [:commit, :show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:confirmation, :commit, :new, :edit, :update, :destroy]

  def confirmation
    @deal = Deal.find(params[:deal_id])
  end

  def commit
    @deal.users << current_user
    flash[:notice] = "Committed!"
    redirect_to @deal
  end

  # GET /deals
  # GET /deals.json
  def index
    if params[:search]
      @deals = Deal.search(params[:search])
    else
      @deals = Deal.all
    end
  end

  # GET /deals/1
  # GET /deals/1.json
  def show
    @comment = Comment.new
  end

  # GET /deals/new
  def new
    @deal = Deal.new
  end

  # GET /deals/1/edit
  def edit
    authorize @deal, :owner?
  end

  # POST /deals
  # POST /deals.json
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

  # PATCH/PUT /deals/1
  # PATCH/PUT /deals/1.json
  def update
    respond_to do |format|
      authorize @deal, :owner?
      if @deal.update(deal_params)
        format.html { redirect_to @deal, notice: 'Deal was successfully updated.' }
        format.json { render :show, status: :ok, location: @deal }
      else
        format.html { render :edit }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deals/1
  # DELETE /deals/1.json
  def destroy
    authorize @deal, :owner?
    @deal.destroy
    respond_to do |format|
      format.html { redirect_to deals_url, notice: 'Deal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deal
      @deal = Deal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deal_params
      params.require(:deal).permit(:title, :image, :description, :goal, :location, :start, :end, :published, :private, :amount, :owner_id, :user_id => [])
    end
end
