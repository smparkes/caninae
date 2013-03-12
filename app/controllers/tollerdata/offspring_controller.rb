class Tollerdata::OffspringController < Tollerdata::TollerdataController
  def index
    @animal = Animal.find params[:animal_id]
    where = nil
    if @animal.sex == "female"
      where = "animals.mother_id = #{@animal.id} and parent.id = animals.father_id"
    else
      where = "animals.father_id = #{@animal.id} and parent.id = animals.mother_id"
    end
    @offspring =
      Animal.
      joins("join animals as parent").
      where(where).
      order("parent.name, animals.name")
  end
end
