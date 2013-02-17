require 'test_helper'

class PreceedsControllerTest < ActionController::TestCase
  setup do
    @preceed = preceeds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:preceeds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create preceed" do
    assert_difference('Preceed.count') do
      post :create, preceed: { first: @preceed.first, second: @preceed.second }
    end

    assert_redirected_to preceed_path(assigns(:preceed))
  end

  test "should show preceed" do
    get :show, id: @preceed
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @preceed
    assert_response :success
  end

  test "should update preceed" do
    put :update, id: @preceed, preceed: { first: @preceed.first, second: @preceed.second }
    assert_redirected_to preceed_path(assigns(:preceed))
  end

  test "should destroy preceed" do
    assert_difference('Preceed.count', -1) do
      delete :destroy, id: @preceed
    end

    assert_redirected_to preceeds_path
  end
end
