module QuestionsHelper
  def question_header(test, title)
    if title == 'create'
      return "Create new question for #{test.title}"
    else
      return "Edit #{test.title} question"
    end
  end
end
