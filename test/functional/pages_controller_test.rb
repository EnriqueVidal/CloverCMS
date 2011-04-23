require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  def setup
    @section  = Factory.create :section
    @page     = Factory.create :page, :section => @section, :home_page => true
  end

  test "anyone can hit show" do
    get :show, :page => @page.url_name, :section => @section.url_name
    assert_response :success
    assert_template :show
  end

  test "anyone can hit the homepage" do
    get :home
    assert_response :success
    assert_template :show
  end
end
