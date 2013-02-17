class ClearancesController < ApplicationController
  # GET /clearances
  # GET /clearances.json
  def index
    @clearances = Clearance.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clearances }
    end
  end

  # GET /clearances/1
  # GET /clearances/1.json
  def show
    @clearance = Clearance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @clearance }
    end
  end

  # GET /clearances/new
  # GET /clearances/new.json
  def new
    @clearance = Clearance.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @clearance }
    end
  end

  # GET /clearances/1/edit
  def edit
    @clearance = Clearance.find(params[:id])
  end

  # POST /clearances
  # POST /clearances.json
  def create
    @clearance = Clearance.new(params[:clearance])

    respond_to do |format|
      if @clearance.save
        format.html { redirect_to @clearance, notice: 'Clearance was successfully created.' }
        format.json { render json: @clearance, status: :created, location: @clearance }
      else
        format.html { render action: "new" }
        format.json { render json: @clearance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clearances/1
  # PUT /clearances/1.json
  def update
    @clearance = Clearance.find(params[:id])

    respond_to do |format|
      if @clearance.update_attributes(params[:clearance])
        format.html { redirect_to @clearance, notice: 'Clearance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @clearance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clearances/1
  # DELETE /clearances/1.json
  def destroy
    @clearance = Clearance.find(params[:id])
    @clearance.destroy

    respond_to do |format|
      format.html { redirect_to clearances_url }
      format.json { head :no_content }
    end
  end
end
