require 'test_helper'

class KennelLittersControllerTest < ActionController::TestCase
  setup do
    @kennel_litter = kennel_litters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kennel_litters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kennel_litter" do
    assert_difference('KennelLitter.count') do
      post :create, kennel_litter: { kennel_id: @kennel_litter.kennel_id, litter_id: @kennel_litter.litter_id }
    end

    assert_redirected_to kennel_litter_path(assigns(:kennel_litter))
  end

  test "should show kennel_litter" do
    get :show, id: @kennel_litter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @kennel_litter
    assert_response :success
  end

  test "should update kennel_litter" do
    put :update, id: @kennel_litter, kennel_litter: { kennel_id: @kennel_litter.kennel_id, litter_id: @kennel_litter.litter_id }
    assert_redirected_to kennel_litter_path(assigns(:kennel_litter))
  end

  test "should destroy kennel_litter" do
    assert_difference('KennelLitter.count', -1) do
      delete :destroy, id: @kennel_litter
    end

    assert_redirected_to kennel_litters_path
  end
end
