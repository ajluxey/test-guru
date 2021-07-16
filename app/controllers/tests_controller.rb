class TestsController < ApplicationController

  before_action :find_test, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index
    @tests = Test.all
  end

  def new
    @test = Test.new()
  end

  def create
    author = User.first
    @test = Test.new(test_params.merge author_id: author.id)
    if @test.save
      redirect_to @test
    else
      render :new
    end
  end

  def update
    if @test.update(test_params)
      redirect_to @test
    else
      render :edit
    end
  end

  def destroy
    @test.destroy
    redirect_to tests_path
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end

  def test_params
    # Автор - обязательный параметр, пока что ставлю 1, пока нет авторизации
    params.require(:test).permit(:title, :level, :category_id).merge author_id: 1
  end

  def rescue_with_test_not_found
    render plain: "Test with id = #{params[:id]} not found"
  end
end
