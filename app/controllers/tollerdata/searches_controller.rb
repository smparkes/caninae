class Tollerdata::SearchesController < Tollerdata::TollerdataController
  def create
    render_animals_for params[tollerdata_verify]
  end
end
