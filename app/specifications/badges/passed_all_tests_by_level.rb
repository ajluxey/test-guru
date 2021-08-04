require_relative 'passed_all_tests_by_some_condition'

class PassedAllTestsByLevel < PassedAllTestsBySomeCondition
  def satisfied_with?(test_passage)
    if @rule_value.to_i == test_passage.test.level
      super(test_passage, { test: Test.where(level: @rule_value) })
    else
      false
    end
  end
end
