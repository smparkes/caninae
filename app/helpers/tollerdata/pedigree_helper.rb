module Tollerdata::PedigreeHelper

  def pedigree_path animal, pedigree_click, generations
    case pedigree_click
    when :pedigree;  tollerdata_animal_pedigree_path(animal.id, generations )
    else; tollerdata_animal_path(animal)
    end
  end

end
