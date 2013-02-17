class PersonKennelsController < ApplicationController
  # GET /person_kennels
  # GET /person_kennels.json
  def index
    @person_kennels = PersonKennel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @person_kennels }
    end
  end

  # GET /person_kennels/1
  # GET /person_kennels/1.json
  def show
    @person_kennel = PersonKennel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @person_kennel }
    end
  end

  # GET /person_kennels/new
  # GET /person_kennels/new.json
  def new
    @person_kennel = PersonKennel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @person_kennel }
    end
  end

  # GET /person_kennels/1/edit
  def edit
    @person_kennel = PersonKennel.find(params[:id])
  end

  # POST /person_kennels
  # POST /person_kennels.json
  def create
    @person_kennel = PersonKennel.new(params[:person_kennel])

    respond_to do |format|
      if @person_kennel.save
        format.html { redirect_to @person_kennel, notice: 'Person kennel was successfully created.' }
        format.json { render json: @person_kennel, status: :created, location: @person_kennel }
      else
        format.html { render action: "new" }
        format.json { render json: @person_kennel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /person_kennels/1
  # PUT /person_kennels/1.json
  def update
    @person_kennel = PersonKennel.find(params[:id])

    respond_to do |format|
      if @person_kennel.update_attributes(params[:person_kennel])
        format.html { redirect_to @person_kennel, notice: 'Person kennel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @person_kennel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /person_kennels/1
  # DELETE /person_kennels/1.json
  def destroy
    @person_kennel = PersonKennel.find(params[:id])
    @person_kennel.destroy

    respond_to do |format|
      format.html { redirect_to person_kennels_url }
      format.json { head :no_content }
    end
  end
end
