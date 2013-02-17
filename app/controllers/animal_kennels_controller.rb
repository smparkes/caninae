class AnimalKennelsController < ApplicationController
  # GET /animal_kennels
  # GET /animal_kennels.json
  def index
    @animal_kennels = AnimalKennel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @animal_kennels }
    end
  end

  # GET /animal_kennels/1
  # GET /animal_kennels/1.json
  def show
    @animal_kennel = AnimalKennel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @animal_kennel }
    end
  end

  # GET /animal_kennels/new
  # GET /animal_kennels/new.json
  def new
    @animal_kennel = AnimalKennel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @animal_kennel }
    end
  end

  # GET /animal_kennels/1/edit
  def edit
    @animal_kennel = AnimalKennel.find(params[:id])
  end

  # POST /animal_kennels
  # POST /animal_kennels.json
  def create
    @animal_kennel = AnimalKennel.new(params[:animal_kennel])

    respond_to do |format|
      if @animal_kennel.save
        format.html { redirect_to @animal_kennel, notice: 'Animal kennel was successfully created.' }
        format.json { render json: @animal_kennel, status: :created, location: @animal_kennel }
      else
        format.html { render action: "new" }
        format.json { render json: @animal_kennel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /animal_kennels/1
  # PUT /animal_kennels/1.json
  def update
    @animal_kennel = AnimalKennel.find(params[:id])

    respond_to do |format|
      if @animal_kennel.update_attributes(params[:animal_kennel])
        format.html { redirect_to @animal_kennel, notice: 'Animal kennel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @animal_kennel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /animal_kennels/1
  # DELETE /animal_kennels/1.json
  def destroy
    @animal_kennel = AnimalKennel.find(params[:id])
    @animal_kennel.destroy

    respond_to do |format|
      format.html { redirect_to animal_kennels_url }
      format.json { head :no_content }
    end
  end
end
