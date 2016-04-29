require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "enter username, store username in db" do
    get login_path
    assert_template 'welcomepage/show'
    post login_path, username:""
    assert_template 'welcomepage/show'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end
