class UpdatesController < ApplicationController
  before_action :set_update, only: [:edit, :update, :destroy]
  before_action :set_deal, only: [:new, :create, :edit, :update, :destroy]

  # GET /updates/new
  def new
    @update = Update.new
    authorize @deal, :owner?
  end

  # GET /updates/1/edit
  def edit
    authorize @deal, :owner?
  end

  # POST /updates
  # POST /updates.json
  def create
    @update = Update.new(update_params)
    @update.deal_id = @deal.id
    respond_to do |format|
      authorize @deal, :owner?
      if @update.save
        format.html { redirect_to @deal, notice: 'Update was successfully created.' }
        format.json { render :show, status: :created, location: @update }
      else
        format.html { render :new }
        format.json { render json: @update.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /updates/1
  # PATCH/PUT /updates/1.json
  def update
    respond_to do |format|
      authorize @deal, :owner?
      if @update.update(update_params)
        format.html { redirect_to @deal, notice: 'Update was successfully updated.' }
        format.json { render :show, status: :ok, location: @update }
      else
        format.html { render :edit }
        format.json { render json: @update.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /updates/1
  # DELETE /updates/1.json
  def destroy
    authorize @deal, :owner?
    @update.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Update was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_update
      @update = Update.find(params[:id])
    end

    def set_deal
      @deal = Deal.find(params[:deal_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def update_params
      params.require(:update).permit(:content)
    end
end
