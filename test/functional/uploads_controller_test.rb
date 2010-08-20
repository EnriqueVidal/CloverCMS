require 'test_helper'

class UploadsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:uploads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create upload" do
    assert_difference('Upload.count') do
      post :create, :upload => { }
    end

    assert_redirected_to upload_path(assigns(:upload))
  end

  test "should show upload" do
    get :show, :id => uploads(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => uploads(:one).to_param
    assert_response :success
  end

  test "should update upload" do
    put :update, :id => uploads(:one).to_param, :upload => { }
    assert_redirected_to upload_path(assigns(:upload))
  end

  test "should destroy upload" do
    assert_difference('Upload.count', -1) do
      delete :destroy, :id => uploads(:one).to_param
    end

    assert_redirected_to uploads_path
  end
end
