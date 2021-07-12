module QuestionsHelper
  def question_header(question, action)
    case action
    when :new
      return "Create new question for #{question.test.title}"
    when :edit
      return "Edit #{question.test.title} question"
    else
      return "Unknown action for #{question.test.title} question"
    end
  end
end
