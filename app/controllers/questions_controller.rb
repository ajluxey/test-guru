class QuestionsController < ApplicationController
  
  before_action :find_test, only: %i[index new create]
  before_action :find_question, only: %i[show destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    response_str = "All questions for test \"#{@test.title}\":\n"
    @test.questions.pluck(:id, :body).each { |id, body| response_str += "id: #{id}; Question: \"#{body}\"\n" }
    render plain: response_str
  end

  def show
    render plain: @question.body
  end

  def new
    @question = @test.questions.new
  end

  def create
    @question = @test.questions.new(question_params)
    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def destroy
    @question.destroy
    redirect_to @question
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:body)
  end

  def rescue_with_question_not_found
    render plain: "Question with id = #{params[:id]} not found"
  end
end
