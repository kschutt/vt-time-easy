class CampusController < ApplicationController
  before_filter :authenticate_user!
  # GET /campus
  # GET /campus.json
  def index
    @campus = Campu.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @campus }
    end
  end

  # GET /campus/1
  # GET /campus/1.json
  def show
    @campu = Campu.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @campu }
    end
  end

  # GET /campus/new
  # GET /campus/new.json
  def new
    @campu = Campu.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @campu }
    end
  end

  # GET /campus/1/edit
  def edit
    @campu = Campu.find(params[:id])
  end

  # POST /campus
  # POST /campus.json
  def create
    @campu = Campu.new(params[:campu])

    respond_to do |format|
      if @campu.save
        format.html { redirect_to @campu, notice: 'Campu was successfully created.' }
        format.json { render json: @campu, status: :created, location: @campu }
      else
        format.html { render action: "new" }
        format.json { render json: @campu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /campus/1
  # PUT /campus/1.json
  def update
    @campu = Campu.find(params[:id])

    respond_to do |format|
      if @campu.update_attributes(params[:campu])
        format.html { redirect_to @campu, notice: 'Campu was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @campu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campus/1
  # DELETE /campus/1.json
  def destroy
    @campu = Campu.find(params[:id])
    @campu.destroy

    respond_to do |format|
      format.html { redirect_to campus_url }
      format.json { head :no_content }
    end
  end
end
