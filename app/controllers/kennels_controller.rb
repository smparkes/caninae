class KennelsController < ApplicationController
  # GET /kennels
  # GET /kennels.json
  def index
    @kennels = Kennel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @kennels }
    end
  end

  # GET /kennels/1
  # GET /kennels/1.json
  def show
    @kennel = Kennel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @kennel }
    end
  end

  # GET /kennels/new
  # GET /kennels/new.json
  def new
    @kennel = Kennel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @kennel }
    end
  end

  # GET /kennels/1/edit
  def edit
    @kennel = Kennel.find(params[:id])
  end

  # POST /kennels
  # POST /kennels.json
  def create
    @kennel = Kennel.new(params[:kennel])

    respond_to do |format|
      if @kennel.save
        format.html { redirect_to @kennel, notice: 'Kennel was successfully created.' }
        format.json { render json: @kennel, status: :created, location: @kennel }
      else
        format.html { render action: "new" }
        format.json { render json: @kennel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /kennels/1
  # PUT /kennels/1.json
  def update
    @kennel = Kennel.find(params[:id])

    respond_to do |format|
      if @kennel.update_attributes(params[:kennel])
        format.html { redirect_to @kennel, notice: 'Kennel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @kennel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kennels/1
  # DELETE /kennels/1.json
  def destroy
    @kennel = Kennel.find(params[:id])
    @kennel.destroy

    respond_to do |format|
      format.html { redirect_to kennels_url }
      format.json { head :no_content }
    end
  end
end
