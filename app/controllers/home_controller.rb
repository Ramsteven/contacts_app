class HomeController < ApplicationController
  def index
    @user = current_user.id
  end
end
