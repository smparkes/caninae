module AnimalsHelper
  def mother
    Animal.find_by_id @animal.mother_id
  end

  def father
    Animal.find_by_id @animal.father_id
  end
end
