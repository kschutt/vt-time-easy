class VtclassesController < ApplicationController
  load_and_authorize_resource
  include ApplicationHelper
  # GET /vtclasses
  # GET /vtclasses.json
  def index
    @vtclasses = current_user.vtclasses.order(:campus, :subject_code, :course_number)
    # @fetcher = VtclassFetch.new
    # raise @fetcher.fetch_classes("CS",201409,"0").to_yaml

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vtclasses }
    end
  end

  # GET /vtclasses/1
  # GET /vtclasses/1.json
  def show
    @vtclass = Vtclass.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vtclass }
    end
  end

  # GET /vtclasses/new
  # GET /vtclasses/new.json
  def new
    @vtclass = Vtclass.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vtclass }
    end
  end

  # GET /vtclasses/1/edit
  def edit
    @vtclass = Vtclass.find(params[:id])
  end

  # POST /vtclasses
  # POST /vtclasses.json
  def create

    @vtclass = check_for_multiple_classes(params)

    respond_to do |format|
      if @vtclass.save
        format.html { redirect_to vtclasses_url, notice: 'Vtclass was successfully created.' }
        format.json { render json: @vtclass, status: :created, location: @vtclass }
      else
        format.html { render action: "new" }
        format.json { render json: @vtclass.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /vtclasses/1
  # PUT /vtclasses/1.json
  def update
    @vtclass = Vtclass.find(params[:id])

    respond_to do |format|
      if @vtclass.update_attributes(params[:vtclass])
        format.html { redirect_to vtclasses_url, notice: 'Vtclass was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vtclass.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vtclasses/1
  # DELETE /vtclasses/1.json
  def destroy
    @vtclass = Vtclass.find(params[:id])
    @vtclass.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end
