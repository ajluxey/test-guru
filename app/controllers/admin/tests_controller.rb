class Admin::TestsController < Admin::BaseController

  before_action :find_tests, only: %i[index update_inline]
  before_action :find_test, only: %i[show edit update update_inline destroy start]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index
  end

  def new
    @test = Test.new()
  end

  def create
    @test = current_user.created_tests.build(test_params)
    byebug
    if @test.save
      redirect_to [:admin, @test]
    else
      render :new
    end
  end

  def update
    if @test.update(test_params)
      redirect_to [:admin, @test]
    else
      render :edit
    end
  end

  def update_inline
    if @test.update(test_params)
      redirect_to admin_tests_path
    else
      render :index
    end
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end

  def find_tests
    @tests = Test.all
  end

  def test_params
    all = (1..6)
    hours_mins_secs = (4..6)
    datetime_keys = -> (range) { range.map { |i| "time_to_pass(#{i}i)".to_s } }

    if params.require(:test).slice(*datetime_keys.call(hours_mins_secs)).values.all?(&:empty?)
      datetime_keys.call(all).each { |key| params[:test].delete(key) }
      params[:test][:time_to_pass] = nil
    end
    params.require(:test).permit(:title, :level, :category_id, :time_to_pass)
  end

  def rescue_with_test_not_found
    render plain: "Test with id = #{params[:id]} not found"
  end
end
