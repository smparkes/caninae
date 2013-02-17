require 'test_helper'

class AnimalOwnersControllerTest < ActionController::TestCase
  setup do
    @animal_owner = animal_owners(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:animal_owners)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create animal_owner" do
    assert_difference('AnimalOwner.count') do
      post :create, animal_owner: { animal_id: @animal_owner.animal_id, owner_id: @animal_owner.owner_id }
    end

    assert_redirected_to animal_owner_path(assigns(:animal_owner))
  end

  test "should show animal_owner" do
    get :show, id: @animal_owner
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @animal_owner
    assert_response :success
  end

  test "should update animal_owner" do
    put :update, id: @animal_owner, animal_owner: { animal_id: @animal_owner.animal_id, owner_id: @animal_owner.owner_id }
    assert_redirected_to animal_owner_path(assigns(:animal_owner))
  end

  test "should destroy animal_owner" do
    assert_difference('AnimalOwner.count', -1) do
      delete :destroy, id: @animal_owner
    end

    assert_redirected_to animal_owners_path
  end
end
