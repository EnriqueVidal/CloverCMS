require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  setup do
    @section  = Factory :section
    @page     = Factory :page, :section => @section, :home_page => true
  end

  test "anyone can hit show" do
    get :show, :page_name => @page.url_name, :section_name => @section.url_name
    assert_response :success
    assert_template :show
  end

  test "root maps to pagescontroller show" do
    get :show, :home_page => true
    assert_response :success
    assert_template :show
  end
end
