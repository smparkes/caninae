class KennelLittersController < ApplicationController
  # GET /kennel_litters
  # GET /kennel_litters.json
  def index
    @kennel_litters = KennelLitter.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @kennel_litters }
    end
  end

  # GET /kennel_litters/1
  # GET /kennel_litters/1.json
  def show
    @kennel_litter = KennelLitter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @kennel_litter }
    end
  end

  # GET /kennel_litters/new
  # GET /kennel_litters/new.json
  def new
    @kennel_litter = KennelLitter.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @kennel_litter }
    end
  end

  # GET /kennel_litters/1/edit
  def edit
    @kennel_litter = KennelLitter.find(params[:id])
  end

  # POST /kennel_litters
  # POST /kennel_litters.json
  def create
    @kennel_litter = KennelLitter.new(params[:kennel_litter])

    respond_to do |format|
      if @kennel_litter.save
        format.html { redirect_to @kennel_litter, notice: 'Kennel litter was successfully created.' }
        format.json { render json: @kennel_litter, status: :created, location: @kennel_litter }
      else
        format.html { render action: "new" }
        format.json { render json: @kennel_litter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /kennel_litters/1
  # PUT /kennel_litters/1.json
  def update
    @kennel_litter = KennelLitter.find(params[:id])

    respond_to do |format|
      if @kennel_litter.update_attributes(params[:kennel_litter])
        format.html { redirect_to @kennel_litter, notice: 'Kennel litter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @kennel_litter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kennel_litters/1
  # DELETE /kennel_litters/1.json
  def destroy
    @kennel_litter = KennelLitter.find(params[:id])
    @kennel_litter.destroy

    respond_to do |format|
      format.html { redirect_to kennel_litters_url }
      format.json { head :no_content }
    end
  end
end
