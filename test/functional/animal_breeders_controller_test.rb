require 'test_helper'

class AnimalBreedersControllerTest < ActionController::TestCase
  setup do
    @animal_breeder = animal_breeders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:animal_breeders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create animal_breeder" do
    assert_difference('AnimalBreeder.count') do
      post :create, animal_breeder: { animal_id: @animal_breeder.animal_id, breeder_id: @animal_breeder.breeder_id }
    end

    assert_redirected_to animal_breeder_path(assigns(:animal_breeder))
  end

  test "should show animal_breeder" do
    get :show, id: @animal_breeder
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @animal_breeder
    assert_response :success
  end

  test "should update animal_breeder" do
    put :update, id: @animal_breeder, animal_breeder: { animal_id: @animal_breeder.animal_id, breeder_id: @animal_breeder.breeder_id }
    assert_redirected_to animal_breeder_path(assigns(:animal_breeder))
  end

  test "should destroy animal_breeder" do
    assert_difference('AnimalBreeder.count', -1) do
      delete :destroy, id: @animal_breeder
    end

    assert_redirected_to animal_breeders_path
  end
end
