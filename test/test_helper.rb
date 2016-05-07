ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def is_logged_in?
    !session[:user_id].nil?
  end

  def log_in(user)
    session[USER_SESSION_ID] = user.id
    user.remember
    cookies.permanent.signed[USER_COOKIE_ID] = user.id
    cookies.permanent[USER_COOKIE_TOKEN] = user.remember_token
  end

  def remember_game(game)
    # this method is to store info in session and cookies
    session[GAME_SESSION_ID] = game.id
    cookies.permanent[GAME_COOKIE_ID] = game.id
  end

end
