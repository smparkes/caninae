require 'test_helper'

class ClearancesControllerTest < ActionController::TestCase
  setup do
    @clearance = clearances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clearances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create clearance" do
    assert_difference('Clearance.count') do
      post :create, clearance: { animal_id: @clearance.animal_id }
    end

    assert_redirected_to clearance_path(assigns(:clearance))
  end

  test "should show clearance" do
    get :show, id: @clearance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @clearance
    assert_response :success
  end

  test "should update clearance" do
    put :update, id: @clearance, clearance: { animal_id: @clearance.animal_id }
    assert_redirected_to clearance_path(assigns(:clearance))
  end

  test "should destroy clearance" do
    assert_difference('Clearance.count', -1) do
      delete :destroy, id: @clearance
    end

    assert_redirected_to clearances_path
  end
end
