class QuestionsController < ApplicationController
  def show
    @question_prefecture = Prefecture.order("RANDOM()").first
    @answer_options = Prefecture.where.not(id: @question_prefecture.id).order("RANDOM()").limit(8)
  end

  def result
    @question_prefecture = Prefecture.find(params[:question_prefecture_id])
    @selected_options = params[:answers].map(&:to_i)
    selected_prefectures = Prefecture.where(id: @selected_options)
    @total_population = selected_prefectures.sum(:population)
    @difference = (@question_prefecture.population - @total_population).abs
    @all_options = Prefecture.all
  end
end