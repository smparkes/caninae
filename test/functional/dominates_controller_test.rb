require 'test_helper'

class DominatesControllerTest < ActionController::TestCase
  setup do
    @dominate = dominates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dominates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dominate" do
    assert_difference('Dominate.count') do
      post :create, dominate: { dominated_id: @dominate.dominated_id, dominator_id: @dominate.dominator_id }
    end

    assert_redirected_to dominate_path(assigns(:dominate))
  end

  test "should show dominate" do
    get :show, id: @dominate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dominate
    assert_response :success
  end

  test "should update dominate" do
    put :update, id: @dominate, dominate: { dominated_id: @dominate.dominated_id, dominator_id: @dominate.dominator_id }
    assert_redirected_to dominate_path(assigns(:dominate))
  end

  test "should destroy dominate" do
    assert_difference('Dominate.count', -1) do
      delete :destroy, id: @dominate
    end

    assert_redirected_to dominates_path
  end
end
