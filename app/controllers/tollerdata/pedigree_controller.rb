class Tollerdata::PedigreeController < Tollerdata::TollerdataController

  def show
    @animal = Animal.find params[:animal_id]
    @generations = (params[:pedigree_id] || params[:id]).to_i
    @pedigree_click = :pedigree
    render :show
  end

  def hip
    @annotation = :hip
    show
  end

  def longevity
    @annotation = :longevity
    show
  end

end
