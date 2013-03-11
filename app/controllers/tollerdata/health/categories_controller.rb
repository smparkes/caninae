class Tollerdata::Health::CategoriesController < Tollerdata::TollerdataController

  def show
    render("tollerdata/healths/show", locals:{
             animal:Animal.find(params[:animal_id]),
             category:Tollerdata::Health::Category.find(params[:id])})
  end

end
