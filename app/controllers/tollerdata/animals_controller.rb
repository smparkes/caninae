class Tollerdata::AnimalsController < Tollerdata::TollerdataController
  def index
    if params[:query]
      q = "%#{params[:query]}%"
      @animals =
        Animal.where("name like ? or call_name like ? collate nocase", q, q)
    else 
      @animals = Animal.limit(10)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @animals }
    end
  end

  def show
    @animal = Animal.find params[:id]
  end
end
