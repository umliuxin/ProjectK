require 'test_helper'

class GameListControllerTest < ActionController::TestCase
  def setup
    session[:username] = 'testuser'
  end

  test "should get welcome page" do
    session[:username] = nil
    get :show
    assert_response 302
  end



  test "should get game list page" do
    get :show
    assert_response :success
  end

end
