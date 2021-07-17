module TestPassagesHelper
  def color_result(test_passage)
    result = test_passage.calculate_result
    if test_passage.successfully_passed?
      content_tag :span, "#{'%.2f' % result}%", style: 'color: green;'
    else
      content_tag :span, "#{'%.2f' % result}%", style: 'color: red;'
    end
  end

  def question_numeration(test_passage)
    "(#{test_passage.test.questions.order(:id).index(test_passage.current_question) + 1}/#{test_passage.test.questions.count})"
  end

  def passage_message(test_passage)
    if test_passage.successfully_passed?
      'Congratulation! You passed this test!'
    else
      'Sorry, test failed. Learn more and try again!'
    end
  end
end
