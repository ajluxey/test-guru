module TestPassagesHelper
  PASSAGE_TRESHOLD = 85

  def color_result(test_passage)
    result = calculate_result(test_passage)
    if result < PASSAGE_TRESHOLD
      content_tag :span, "#{'%.2f' % result}%", style: 'color: red;'
    else
      content_tag :span, "#{'%.2f' % result}%", style: 'color: green;'
    end
  end

  def question_numeration(test_passage)
    "(#{test_passage.test.questions.order(:id).index(test_passage.current_question) + 1}/#{test_passage.test.questions.count})"
  end

  def passage_message(test_passage)
    if calculate_result(test_passage) < PASSAGE_TRESHOLD
      'Sorry, test failed. Learn more and try again!'
    else
      'Congratulation! You passed this test!'
    end
  end

  private

  def calculate_result(test_passage)
    if test_passage.correct_questions > 0
      test_passage.correct_questions.to_f / test_passage.test.questions.count * 100
    else
      0
    end
  end
end
