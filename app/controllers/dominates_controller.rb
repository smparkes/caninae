class DominatesController < ApplicationController
  # GET /dominates
  # GET /dominates.json
  def index
    @dominates = Dominate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dominates }
    end
  end

  # GET /dominates/1
  # GET /dominates/1.json
  def show
    @dominate = Dominate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dominate }
    end
  end

  # GET /dominates/new
  # GET /dominates/new.json
  def new
    @dominate = Dominate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dominate }
    end
  end

  # GET /dominates/1/edit
  def edit
    @dominate = Dominate.find(params[:id])
  end

  # POST /dominates
  # POST /dominates.json
  def create
    @dominate = Dominate.new(params[:dominate])

    respond_to do |format|
      if @dominate.save
        format.html { redirect_to @dominate, notice: 'Dominate was successfully created.' }
        format.json { render json: @dominate, status: :created, location: @dominate }
      else
        format.html { render action: "new" }
        format.json { render json: @dominate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dominates/1
  # PUT /dominates/1.json
  def update
    @dominate = Dominate.find(params[:id])

    respond_to do |format|
      if @dominate.update_attributes(params[:dominate])
        format.html { redirect_to @dominate, notice: 'Dominate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dominate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dominates/1
  # DELETE /dominates/1.json
  def destroy
    @dominate = Dominate.find(params[:id])
    @dominate.destroy

    respond_to do |format|
      format.html { redirect_to dominates_url }
      format.json { head :no_content }
    end
  end
end
