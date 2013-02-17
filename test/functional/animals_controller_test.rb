require 'test_helper'

class AnimalsControllerTest < ActionController::TestCase
  setup do
    @animal = animals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:animals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create animal" do
    assert_difference('Animal.count') do
      post :create, animal: { address_id: @animal.address_id, birth_id: @animal.birth_id, call_name: @animal.call_name, death_id: @animal.death_id, father_id: @animal.father_id, import_json: @animal.import_json, litter_id: @animal.litter_id, mother_id: @animal.mother_id, name: @animal.name, sex: @animal.sex }
    end

    assert_redirected_to animal_path(assigns(:animal))
  end

  test "should show animal" do
    get :show, id: @animal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @animal
    assert_response :success
  end

  test "should update animal" do
    put :update, id: @animal, animal: { address_id: @animal.address_id, birth_id: @animal.birth_id, call_name: @animal.call_name, death_id: @animal.death_id, father_id: @animal.father_id, import_json: @animal.import_json, litter_id: @animal.litter_id, mother_id: @animal.mother_id, name: @animal.name, sex: @animal.sex }
    assert_redirected_to animal_path(assigns(:animal))
  end

  test "should destroy animal" do
    assert_difference('Animal.count', -1) do
      delete :destroy, id: @animal
    end

    assert_redirected_to animals_path
  end
end
