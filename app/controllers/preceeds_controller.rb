class PreceedsController < ApplicationController
  # GET /preceeds
  # GET /preceeds.json
  def index
    @preceeds = Preceed.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @preceeds }
    end
  end

  # GET /preceeds/1
  # GET /preceeds/1.json
  def show
    @preceed = Preceed.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @preceed }
    end
  end

  # GET /preceeds/new
  # GET /preceeds/new.json
  def new
    @preceed = Preceed.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @preceed }
    end
  end

  # GET /preceeds/1/edit
  def edit
    @preceed = Preceed.find(params[:id])
  end

  # POST /preceeds
  # POST /preceeds.json
  def create
    @preceed = Preceed.new(params[:preceed])

    respond_to do |format|
      if @preceed.save
        format.html { redirect_to @preceed, notice: 'Preceed was successfully created.' }
        format.json { render json: @preceed, status: :created, location: @preceed }
      else
        format.html { render action: "new" }
        format.json { render json: @preceed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /preceeds/1
  # PUT /preceeds/1.json
  def update
    @preceed = Preceed.find(params[:id])

    respond_to do |format|
      if @preceed.update_attributes(params[:preceed])
        format.html { redirect_to @preceed, notice: 'Preceed was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @preceed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /preceeds/1
  # DELETE /preceeds/1.json
  def destroy
    @preceed = Preceed.find(params[:id])
    @preceed.destroy

    respond_to do |format|
      format.html { redirect_to preceeds_url }
      format.json { head :no_content }
    end
  end
end
