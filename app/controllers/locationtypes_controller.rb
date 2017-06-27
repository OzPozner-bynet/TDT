class LocationtypesController < ApplicationController
  before_action :set_locationtype, only: [:show, :edit, :update, :destroy]

  # GET /locationtypes
  # GET /locationtypes.json
  def index
    @locationtypes = Locationtype.all
  end

  # GET /locationtypes/1
  # GET /locationtypes/1.json
  def show
  end

  # GET /locationtypes/new
  def new
    @locationtype = Locationtype.new
  end

  # GET /locationtypes/1/edit
  def edit
  end

  # POST /locationtypes
  # POST /locationtypes.json
  def create
    @locationtype = Locationtype.new(locationtype_params)

    respond_to do |format|
      if @locationtype.save
        format.html { redirect_to @locationtype, notice: 'Locationtype was successfully created.' }
        format.json { render :show, status: :created, location: @locationtype }
      else
        format.html { render :new }
        format.json { render json: @locationtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locationtypes/1
  # PATCH/PUT /locationtypes/1.json
  def update
    respond_to do |format|
      if @locationtype.update(locationtype_params)
        format.html { redirect_to @locationtype, notice: 'Locationtype was successfully updated.' }
        format.json { render :show, status: :ok, location: @locationtype }
      else
        format.html { render :edit }
        format.json { render json: @locationtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locationtypes/1
  # DELETE /locationtypes/1.json
  def destroy
    @locationtype.destroy
    respond_to do |format|
      format.html { redirect_to locationtypes_url, notice: 'Locationtype was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_locationtype
      @locationtype = Locationtype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def locationtype_params
      params.require(:locationtype).permit(:name, :icon_id, :icon_url, :insideR, :nearR)
    end
end
