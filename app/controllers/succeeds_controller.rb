class SucceedsController < ApplicationController
  # GET /succeeds
  # GET /succeeds.json
  def index
    @succeeds = Succeed.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @succeeds }
    end
  end

  # GET /succeeds/1
  # GET /succeeds/1.json
  def show
    @succeed = Succeed.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @succeed }
    end
  end

  # GET /succeeds/new
  # GET /succeeds/new.json
  def new
    @succeed = Succeed.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @succeed }
    end
  end

  # GET /succeeds/1/edit
  def edit
    @succeed = Succeed.find(params[:id])
  end

  # POST /succeeds
  # POST /succeeds.json
  def create
    @succeed = Succeed.new(params[:succeed])

    respond_to do |format|
      if @succeed.save
        format.html { redirect_to @succeed, notice: 'Succeed was successfully created.' }
        format.json { render json: @succeed, status: :created, location: @succeed }
      else
        format.html { render action: "new" }
        format.json { render json: @succeed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /succeeds/1
  # PUT /succeeds/1.json
  def update
    @succeed = Succeed.find(params[:id])

    respond_to do |format|
      if @succeed.update_attributes(params[:succeed])
        format.html { redirect_to @succeed, notice: 'Succeed was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @succeed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /succeeds/1
  # DELETE /succeeds/1.json
  def destroy
    @succeed = Succeed.find(params[:id])
    @succeed.destroy

    respond_to do |format|
      format.html { redirect_to succeeds_url }
      format.json { head :no_content }
    end
  end
end
