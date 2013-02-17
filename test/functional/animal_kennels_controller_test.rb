require 'test_helper'

class AnimalKennelsControllerTest < ActionController::TestCase
  setup do
    @animal_kennel = animal_kennels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:animal_kennels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create animal_kennel" do
    assert_difference('AnimalKennel.count') do
      post :create, animal_kennel: { animal_id: @animal_kennel.animal_id, kennel_id: @animal_kennel.kennel_id }
    end

    assert_redirected_to animal_kennel_path(assigns(:animal_kennel))
  end

  test "should show animal_kennel" do
    get :show, id: @animal_kennel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @animal_kennel
    assert_response :success
  end

  test "should update animal_kennel" do
    put :update, id: @animal_kennel, animal_kennel: { animal_id: @animal_kennel.animal_id, kennel_id: @animal_kennel.kennel_id }
    assert_redirected_to animal_kennel_path(assigns(:animal_kennel))
  end

  test "should destroy animal_kennel" do
    assert_difference('AnimalKennel.count', -1) do
      delete :destroy, id: @animal_kennel
    end

    assert_redirected_to animal_kennels_path
  end
end
