require 'test_helper'

class ContactFormsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contact_forms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contact_form" do
    assert_difference('ContactForm.count') do
      post :create, :contact_form => { }
    end

    assert_redirected_to contact_form_path(assigns(:contact_form))
  end

  test "should show contact_form" do
    get :show, :id => contact_forms(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => contact_forms(:one).to_param
    assert_response :success
  end

  test "should update contact_form" do
    put :update, :id => contact_forms(:one).to_param, :contact_form => { }
    assert_redirected_to contact_form_path(assigns(:contact_form))
  end

  test "should destroy contact_form" do
    assert_difference('ContactForm.count', -1) do
      delete :destroy, :id => contact_forms(:one).to_param
    end

    assert_redirected_to contact_forms_path
  end
end
