class AnimalBreedersController < ApplicationController
  # GET /animal_breeders
  # GET /animal_breeders.json
  def index
    @animal_breeders = AnimalBreeder.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @animal_breeders }
    end
  end

  # GET /animal_breeders/1
  # GET /animal_breeders/1.json
  def show
    @animal_breeder = AnimalBreeder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @animal_breeder }
    end
  end

  # GET /animal_breeders/new
  # GET /animal_breeders/new.json
  def new
    @animal_breeder = AnimalBreeder.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @animal_breeder }
    end
  end

  # GET /animal_breeders/1/edit
  def edit
    @animal_breeder = AnimalBreeder.find(params[:id])
  end

  # POST /animal_breeders
  # POST /animal_breeders.json
  def create
    @animal_breeder = AnimalBreeder.new(params[:animal_breeder])

    respond_to do |format|
      if @animal_breeder.save
        format.html { redirect_to @animal_breeder, notice: 'Animal breeder was successfully created.' }
        format.json { render json: @animal_breeder, status: :created, location: @animal_breeder }
      else
        format.html { render action: "new" }
        format.json { render json: @animal_breeder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /animal_breeders/1
  # PUT /animal_breeders/1.json
  def update
    @animal_breeder = AnimalBreeder.find(params[:id])

    respond_to do |format|
      if @animal_breeder.update_attributes(params[:animal_breeder])
        format.html { redirect_to @animal_breeder, notice: 'Animal breeder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @animal_breeder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /animal_breeders/1
  # DELETE /animal_breeders/1.json
  def destroy
    @animal_breeder = AnimalBreeder.find(params[:id])
    @animal_breeder.destroy

    respond_to do |format|
      format.html { redirect_to animal_breeders_url }
      format.json { head :no_content }
    end
  end
end
