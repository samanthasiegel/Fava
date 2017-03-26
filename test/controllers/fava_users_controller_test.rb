require 'test_helper'

class FavaUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fava_user = fava_users(:one)
  end

  test "should get index" do
    get fava_users_url
    assert_response :success
  end

  test "should get new" do
    get new_fava_user_url
    assert_response :success
  end

  test "should create fava_user" do
    assert_difference('FavaUser.count') do
      post fava_users_url, params: { fava_user: { email: @fava_user.email, first_name: @fava_user.first_name, last_name: @fava_user.last_name, phone: @fava_user.phone } }
    end

    assert_redirected_to fava_user_url(FavaUser.last)
  end

  test "should show fava_user" do
    get fava_user_url(@fava_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_fava_user_url(@fava_user)
    assert_response :success
  end

  test "should update fava_user" do
    patch fava_user_url(@fava_user), params: { fava_user: { email: @fava_user.email, first_name: @fava_user.first_name, last_name: @fava_user.last_name, phone: @fava_user.phone } }
    assert_redirected_to fava_user_url(@fava_user)
  end

  test "should destroy fava_user" do
    assert_difference('FavaUser.count', -1) do
      delete fava_user_url(@fava_user)
    end

    assert_redirected_to fava_users_url
  end
end
