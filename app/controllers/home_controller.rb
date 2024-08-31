class HomeController < ApplicationController
  def index
    @rankings = Score.joins(:user).order(score: :asc).limit(10)
  end
end