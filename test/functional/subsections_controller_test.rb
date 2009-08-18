require 'test_helper'

class SubsectionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subsections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subsections" do
    assert_difference('Subsections.count') do
      post :create, :subsections => { }
    end

    assert_redirected_to subsections_path(assigns(:subsections))
  end

  test "should show subsections" do
    get :show, :id => subsections(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => subsections(:one).to_param
    assert_response :success
  end

  test "should update subsections" do
    put :update, :id => subsections(:one).to_param, :subsections => { }
    assert_redirected_to subsections_path(assigns(:subsections))
  end

  test "should destroy subsections" do
    assert_difference('Subsections.count', -1) do
      delete :destroy, :id => subsections(:one).to_param
    end

    assert_redirected_to subsections_path
  end
end
