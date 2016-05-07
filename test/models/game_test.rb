require 'test_helper'

class GameTest < ActiveSupport::TestCase
  def setup
    game = games(:testgame)
    @game = Game.new(num_of_player: game.num_of_player,host_id: game.host_id,access_code: game.access_code,is_active: game.is_active, gameroles: game.gameroles)
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
    @game.host_id = -1
    assert_not @game.valid?
  end

  test "gameroles should not be nil" do
    @game.gameroles = nil
    assert_not @game.valid?
  end

  test "gameroles should be only including 0, 1, 2" do
    @game.gameroles = '3333333'
    assert_not @game.valid?
    @game.gameroles = 'b111111'
    assert_not @game.valid?
  end

  test "gameroles length should be inbetween 5 and 12" do
    @game.gameroles='0'
    assert_not @game.valid?
  end



  test "is_active should be true or false" do
    @game.is_active = nil
    assert_not @game.valid?
    @game.is_active = true
    assert @game.valid?
  end

  test "access code should be less than 20 char" do
    @game.access_code='abcabcacbabcabbbacbabcabcbabacbcbabaccba'
    assert_not @game.valid?
  end
end
