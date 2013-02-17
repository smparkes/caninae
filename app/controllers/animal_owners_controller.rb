class AnimalOwnersController < ApplicationController
  # GET /animal_owners
  # GET /animal_owners.json
  def index
    @animal_owners = AnimalOwner.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @animal_owners }
    end
  end

  # GET /animal_owners/1
  # GET /animal_owners/1.json
  def show
    @animal_owner = AnimalOwner.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @animal_owner }
    end
  end

  # GET /animal_owners/new
  # GET /animal_owners/new.json
  def new
    @animal_owner = AnimalOwner.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @animal_owner }
    end
  end

  # GET /animal_owners/1/edit
  def edit
    @animal_owner = AnimalOwner.find(params[:id])
  end

  # POST /animal_owners
  # POST /animal_owners.json
  def create
    @animal_owner = AnimalOwner.new(params[:animal_owner])

    respond_to do |format|
      if @animal_owner.save
        format.html { redirect_to @animal_owner, notice: 'Animal owner was successfully created.' }
        format.json { render json: @animal_owner, status: :created, location: @animal_owner }
      else
        format.html { render action: "new" }
        format.json { render json: @animal_owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /animal_owners/1
  # PUT /animal_owners/1.json
  def update
    @animal_owner = AnimalOwner.find(params[:id])

    respond_to do |format|
      if @animal_owner.update_attributes(params[:animal_owner])
        format.html { redirect_to @animal_owner, notice: 'Animal owner was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @animal_owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /animal_owners/1
  # DELETE /animal_owners/1.json
  def destroy
    @animal_owner = AnimalOwner.find(params[:id])
    @animal_owner.destroy

    respond_to do |format|
      format.html { redirect_to animal_owners_url }
      format.json { head :no_content }
    end
  end
end
