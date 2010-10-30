require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  setup do
    @admin    = Factory(:admin, :email => 'root@site.com')
    @user     = Factory(:user)
    @section  = Factory(:section)
    @page     = Factory(:page, :section_id => @section.id)
  end
  
  test "factories should workd" do
    assert @admin
    assert @section
    assert @page
  end
  
  test "should get index as admin" do
    become :admin
    
    get :index, {:section_id => @section.id}
    assert_response :success
    assert_not_nil assigns(:pages)
  end

  test "should redirect if user is not admin" do
    become :user
    
    get :index, {:section_id => @section.id}
    assert_redirected_to new_user_session_path
  end

  test "should redirect to login if not logged in" do    
    get :index, {:section_id => @section.id}
    assert_redirected_to new_user_session_path
  end

  test "anyone can hit show" do    
    get :show, :page_name => @page.url_name, :section_name => @section.url_name
    assert_response :success
  end
  
  test "should get new if admin" do
    become :admin
    
    get :new, { :section_id => @section.id }
    assert_response :success
  end
  
  test "should not get new if not admin" do
    become :user
    
    get :new, { :section_id => @section.id }
    assert_redirected_to new_user_session_path
  end
  
  test "should create page if admin" do
    become :admin
    
    assert_difference('Page.count') do
      post :create, :section_id => @section.id, :page => Factory.attributes_for(:page, :name => 'newest page', :section_id => @section.id)
    end

    assert_redirected_to section_pages_path(@section)
  end


  test "shouldn't create page if not admin" do
    post :create, :section_id => @section.id, :page => Factory.attributes_for(:page, :name => 'newest page', :section_id => @section.id)
    assert_redirected_to new_user_session_path
  end
  
  test "should get edit if admin" do
    become :admin
    get :edit, :id => @page.id, :section_id => @section.id
    assert_response :success
  end
  
  test "should not get edit if not admin" do
    become :user
    get :edit, :id => @page.id, :section_id => @section.id
    assert_redirected_to new_user_session_path
  end
  
  test "should update page if admin" do
    become :admin
    
    put :update, :section_id => @section.id, :id => @page.id, :page => Factory.attributes_for(:page, :section_id => @section.id)
    assert_redirected_to section_pages_path(@section)
  end
  
  test "shouldn't update page if not admin" do
    put :update, :section_id => @section.id, :id => @page.id, :page => Factory.attributes_for(:page, :section_id => @section.id)
    assert_redirected_to new_user_session_path
  end
  
  test "should destroy page if admin" do
    become :admin
    
    assert_difference('Page.count', -1) do
      delete :destroy, :section_id => @section.id, :id => @page.id
    end

    assert_redirected_to section_pages_path(@section)
  end
  
  def become type=nil
    case type
    when :admin then 
      PagesController.any_instance.stubs(:current_user).returns(@admin)
    when :user  then 
      PagesController.any_instance.stubs(:current_user).returns(@user)
    end
  end
end
