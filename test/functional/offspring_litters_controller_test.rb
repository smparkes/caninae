require 'test_helper'

class OffspringLittersControllerTest < ActionController::TestCase
  setup do
    @offspring_litter = offspring_litters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:offspring_litters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create offspring_litter" do
    assert_difference('OffspringLitter.count') do
      post :create, offspring_litter: { litter_id: @offspring_litter.litter_id, offspring_id: @offspring_litter.offspring_id }
    end

    assert_redirected_to offspring_litter_path(assigns(:offspring_litter))
  end

  test "should show offspring_litter" do
    get :show, id: @offspring_litter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @offspring_litter
    assert_response :success
  end

  test "should update offspring_litter" do
    put :update, id: @offspring_litter, offspring_litter: { litter_id: @offspring_litter.litter_id, offspring_id: @offspring_litter.offspring_id }
    assert_redirected_to offspring_litter_path(assigns(:offspring_litter))
  end

  test "should destroy offspring_litter" do
    assert_difference('OffspringLitter.count', -1) do
      delete :destroy, id: @offspring_litter
    end

    assert_redirected_to offspring_litters_path
  end
end
