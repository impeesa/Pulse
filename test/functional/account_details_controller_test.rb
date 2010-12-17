require 'test_helper'

class AccountDetailsControllerTest < ActionController::TestCase
  setup do
    @account_detail = account_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:account_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create account_detail" do
    assert_difference('AccountDetail.count') do
      post :create, :account_detail => @account_detail.attributes
    end

    assert_redirected_to account_detail_path(assigns(:account_detail))
  end

  test "should show account_detail" do
    get :show, :id => @account_detail.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @account_detail.to_param
    assert_response :success
  end

  test "should update account_detail" do
    put :update, :id => @account_detail.to_param, :account_detail => @account_detail.attributes
    assert_redirected_to account_detail_path(assigns(:account_detail))
  end

  test "should destroy account_detail" do
    assert_difference('AccountDetail.count', -1) do
      delete :destroy, :id => @account_detail.to_param
    end

    assert_redirected_to account_details_path
  end
end
