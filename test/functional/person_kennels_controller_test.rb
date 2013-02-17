require 'test_helper'

class PersonKennelsControllerTest < ActionController::TestCase
  setup do
    @person_kennel = person_kennels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:person_kennels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create person_kennel" do
    assert_difference('PersonKennel.count') do
      post :create, person_kennel: { kennel_id: @person_kennel.kennel_id, person_id: @person_kennel.person_id }
    end

    assert_redirected_to person_kennel_path(assigns(:person_kennel))
  end

  test "should show person_kennel" do
    get :show, id: @person_kennel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @person_kennel
    assert_response :success
  end

  test "should update person_kennel" do
    put :update, id: @person_kennel, person_kennel: { kennel_id: @person_kennel.kennel_id, person_id: @person_kennel.person_id }
    assert_redirected_to person_kennel_path(assigns(:person_kennel))
  end

  test "should destroy person_kennel" do
    assert_difference('PersonKennel.count', -1) do
      delete :destroy, id: @person_kennel
    end

    assert_redirected_to person_kennels_path
  end
end
