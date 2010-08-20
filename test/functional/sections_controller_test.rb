require 'test_helper'

class SectionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sections" do
    assert_difference('Sections.count') do
      post :create, :sections => { }
    end

    assert_redirected_to sections_path(assigns(:sections))
  end

  test "should show sections" do
    get :show, :id => sections(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => sections(:one).to_param
    assert_response :success
  end

  test "should update sections" do
    put :update, :id => sections(:one).to_param, :sections => { }
    assert_redirected_to sections_path(assigns(:sections))
  end

  test "should destroy sections" do
    assert_difference('Sections.count', -1) do
      delete :destroy, :id => sections(:one).to_param
    end

    assert_redirected_to sections_path
  end
end
