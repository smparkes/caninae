class OffspringLittersController < ApplicationController
  # GET /offspring_litters
  # GET /offspring_litters.json
  def index
    @offspring_litters = OffspringLitter.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @offspring_litters }
    end
  end

  # GET /offspring_litters/1
  # GET /offspring_litters/1.json
  def show
    @offspring_litter = OffspringLitter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @offspring_litter }
    end
  end

  # GET /offspring_litters/new
  # GET /offspring_litters/new.json
  def new
    @offspring_litter = OffspringLitter.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @offspring_litter }
    end
  end

  # GET /offspring_litters/1/edit
  def edit
    @offspring_litter = OffspringLitter.find(params[:id])
  end

  # POST /offspring_litters
  # POST /offspring_litters.json
  def create
    @offspring_litter = OffspringLitter.new(params[:offspring_litter])

    respond_to do |format|
      if @offspring_litter.save
        format.html { redirect_to @offspring_litter, notice: 'Offspring litter was successfully created.' }
        format.json { render json: @offspring_litter, status: :created, location: @offspring_litter }
      else
        format.html { render action: "new" }
        format.json { render json: @offspring_litter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /offspring_litters/1
  # PUT /offspring_litters/1.json
  def update
    @offspring_litter = OffspringLitter.find(params[:id])

    respond_to do |format|
      if @offspring_litter.update_attributes(params[:offspring_litter])
        format.html { redirect_to @offspring_litter, notice: 'Offspring litter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @offspring_litter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offspring_litters/1
  # DELETE /offspring_litters/1.json
  def destroy
    @offspring_litter = OffspringLitter.find(params[:id])
    @offspring_litter.destroy

    respond_to do |format|
      format.html { redirect_to offspring_litters_url }
      format.json { head :no_content }
    end
  end
end
