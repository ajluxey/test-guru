class QuestionsController < ApplicationController
  # Это вынужденная мера, т.к. мои рельсы не могут подгрузить в хедере следующую строку
  # <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
  # Это вызывает ошибку Webpacker::Manifest::MissingEntryError in Questions#new
  layout false
  
  before_action :find_test, only: %i[index new create]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  # Method which return all questions for test with id = test_id
  # Prefix - test_questions
  def index
    # Код ниже написан для удобства - чтобы знать какой id у какого вопроса
    # Я знаю, что не совсем корректно "наводить красоту" в контроллере и лучше делать это во View
    # Весь код можно заменить на
    # render plain: @test.questions.pluck(:body).join("\n")
    response_str = "All questions for test \"#{@test.title}\":\n"
    @test.questions.pluck(:id, :body).each { |id, body| response_str += "id: #{id}; Question: \"#{body}\"\n" }
    render plain: response_str
  end

  # Method which return specific question by id
  # Prefix - question
  def show
    render plain: Question.find(params[:id]).body
  end

  def create
    Question.create!(question_params)
  end

  def destroy
    Question.find(params[:id]).destroy
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def question_params
    params.require(:question).permit(:body).merge(test: @test)
  end

  def rescue_with_question_not_found
    render plain: "Question with id = #{params[:id]} not found"
  end
end
