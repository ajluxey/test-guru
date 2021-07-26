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
    current_question_index = test_passage.test.questions.order(:id).index(test_passage.current_question) + 1
    current_question_index = content_tag :span,
                                         current_question_index,
                                         class: "current-progress",
                                         data: { test_passage_id: test_passage.id } 
    questiions_count = content_tag :span,
                                   test_passage.test.questions.count,
                                   class: "full-progress",
                                   data: { test_passage_id: test_passage.id } 
    "(#{current_question_index}/#{questiions_count})".html_safe
  end

  def passage_message(test_passage)
    if test_passage.successfully_passed?
      'Congratulation! You passed this test!'
    else
      'Sorry, test failed. Learn more and try again!'
    end
  end
end
