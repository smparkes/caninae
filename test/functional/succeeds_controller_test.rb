require 'test_helper'

class SucceedsControllerTest < ActionController::TestCase
  setup do
    @succeed = succeeds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:succeeds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create succeed" do
    assert_difference('Succeed.count') do
      post :create, succeed: { first: @succeed.first, second: @succeed.second }
    end

    assert_redirected_to succeed_path(assigns(:succeed))
  end

  test "should show succeed" do
    get :show, id: @succeed
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @succeed
    assert_response :success
  end

  test "should update succeed" do
    put :update, id: @succeed, succeed: { first: @succeed.first, second: @succeed.second }
    assert_redirected_to succeed_path(assigns(:succeed))
  end

  test "should destroy succeed" do
    assert_difference('Succeed.count', -1) do
      delete :destroy, id: @succeed
    end

    assert_redirected_to succeeds_path
  end
end
