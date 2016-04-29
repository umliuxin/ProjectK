class GameListController < ApplicationController
  def show
    ap '>>>>>>>>>>>'
    ap current_user ? current_user : 'not login'
    ap '>>>>>>>>>>>'
  end
end
