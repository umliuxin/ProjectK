require 'test_helper'

class GamelogTest < ActiveSupport::TestCase

  def setup
    pramas = gamelogs(:testgamelog)
    @gamelog = Gamelog.new(user_id: pramas.user_id, game_id: pramas.game_id)
  end


  test "gamelog fixture should be valid" do
    assert @gamelog.valid?
  end

  test "game_id should be valid" do

    @gamelog.game_id = 'a'
    assert_not @gamelog.valid?
    @gamelog.game_id = -1
    assert_not @gamelog.valid?

  end

  test "user_id should be valid" do

    @gamelog.user_id = 'a'
    assert_not @gamelog.valid?
    @gamelog.user_id = -1
    assert_not @gamelog.valid?
  end

  test "is_active cannot be null" do
    @gamelog.is_active = nil
    assert_not @gamelog.valid?
  end

  test "is_win cannot be null" do
    @gamelog.is_win = nil
    assert_not @gamelog.valid?
  end

end
