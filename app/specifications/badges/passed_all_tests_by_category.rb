require_relative 'passed_all_tests_by_some_condition'

class PassedAllTestsByCategory < PassedAllTestsBySomeCondition
  def satisfied_with?(test_passage)
    # ниже подозрительная строка
    if @rule_value.to_i == test_passage.test.category.id
      super(test_passage, { test: Test.where(category: test_passage.test.category) })
    else
      false
    end
  end
end
