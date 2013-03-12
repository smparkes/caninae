class Tollerdata::SiblingsController < Tollerdata::TollerdataController
  def index
    @animal = Animal.find params[:animal_id]
    where = ["id <> #{@animal.id}"]
    args = []
    if @animal.father
      where << "father_id = ?" 
      args << @animal.father.id
    end
    if @animal.mother
      where << "mother_id = ?" 
      args << @animal.mother.id
    end
    if where.empty?
      @siblings = []
    else
      @siblings = Animal.where(where.join(" and "), *args)
    end
  end
end
