class Tollerdata::SearchesController < ApplicationController
  def create
    render_animals_for params[tollerdata_verify]
  end
end
