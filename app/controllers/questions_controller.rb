class QuestionsController < ApplicationController
  def index
    session[:differences] = [] if params[:question_count].to_i == 1
    redirect_to question_path(Prefecture.order("RANDOM()").first, question_count: params[:question_count] || 1)
  end

  def show
    @question_prefecture = Prefecture.order("RANDOM()").first
    @answer_options = Prefecture.where.not(id: @question_prefecture.id).order("RANDOM()").limit(8)
    @question_count = params[:question_count].to_i
  end

  def result
    @question_prefecture = Prefecture.find(params[:question_prefecture_id])
    @answer_option_ids = (params[:answer_option_ids] || []).map(&:to_i)
    @all_options = Prefecture.where(id: @answer_option_ids)
    @selected_options = (params[:answers] || []).map(&:to_i)
    @total_population = @selected_options.sum { |id| Prefecture.find(id).population }
    @difference = @total_population - @question_prefecture.population

    # session[:differences] が nil の場合に空の配列で初期化
    session[:differences] ||= []
    session[:differences] << @difference

    @differences = session[:differences]

    if params[:question_count].to_i >= 3
      @total_difference = session[:differences].map(&:abs).sum
      # current_user が存在する場合のみスコアを保存
      if current_user
        Score.create(user_id: current_user.id, score: @total_difference)
      end
      session[:differences] = []
    end
  end

  def create
    answers = params[:answers] || []
    if answers.empty?
      flash.now[:alert] = "少なくとも一つの選択肢を選択してください。"
      render :new
    else
      @difference = calculate_difference(answers) # 例: calculate_differenceメソッドで差分を計算
      session[:differences] ||= []
      session[:differences] << @difference

      if params[:question_count].to_i >= 3
        @total_difference = session[:differences].map(&:abs).sum
        end
        session[:differences] = []
      end
      redirect_to result_questions_path
    end
  end

  private

  def calculate_difference(answers)
    selected_options = answers.map(&:to_i)
    total_population = selected_options.sum { |id| Prefecture.find(id).population }
    question_prefecture = Prefecture.find(params[:question_prefecture_id])
    total_population - question_prefecture.population
  end
