require 'test_helper'

class GameListControllerTest < ActionController::TestCase
  def setup
    # Login but not in a game
    session[GAME_SESSION_ID] = nil
    cookies[GAME_COOKIE_ID] =nil
    @user = User.new(name: "Example User")
    log_in(@user)
  end

  test "should get welcome page" do
    cookies[USER_COOKIE_ID] = nil
    session[USER_SESSION_ID] = nil
    get :show
    assert_response 302
  end

  test "should get game list page" do
    get :show
    assert_response :success
  end

end
