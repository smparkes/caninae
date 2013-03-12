class Tollerdata::HealthsController < Tollerdata::TollerdataController
  def show
    render "show", locals:{
      animal:Animal.find(params[:animal_id]),
      category:Tollerdata::Health::Category.general_background
    }
  end
end
