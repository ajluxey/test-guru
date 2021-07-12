module QuestionsHelper
  def question_header(question, action)
    case action
    when :new
      "Create new question for #{question.test.title}"
    when :edit
      "Edit #{question.test.title} question"
    else
      "Unknown action for #{question.test.title} question"
    end
  end
end
