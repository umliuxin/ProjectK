require 'test_helper'

class GameTest < ActiveSupport::TestCase
  def setup
    game = games(:testgame)
    @game = Game.new(num_of_player: game.num_of_player,host_id: game.host_id,access_code: game.access_code,is_active: game.is_active)
  end

  test "should be vaild game" do
    assert @game.valid?
  end

  test "number_of_player is a must and bewteen min..max" do
    @game.num_of_player = nil
    assert_not @game.valid?
    @game.num_of_player = GAME_MIN_PLAYER_INCLUSIVE - 1
    assert_not @game.valid?
    @game.num_of_player = GAME_MAX_PLAYER_INCLUSIVE + 1
    assert_not @game.valid?
  end

  test "host_id is a must and in number" do
    @game.host_id = nil
    assert_not @game.valid?

    @game.host_id = 'abc'
    assert_not @game.valid?
  end

  test "host_id should be one existing user's id" do
    @game.host_id = 0
    assert_not @game.valid?
  end

  test "game should be active when saving" do
    @game.is_active = 'a'
    assert_not @game.valid?
    @game.is_active = 0
    assert_not @game.valid?
  end

  test "access code should be less than 20 char" do
    @game.access_code='abcabcacbabcabbbacbabcabcbabacbcbabaccba'
    assert_not @game.valid?
  end
end
