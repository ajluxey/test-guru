class AbstractRuleChecker
  def initialize(rule, rule_value)
    @rule = rule
    @rule_value = rule_value
  end

  def satisfied_with?(test_passage)
    test_passage.successfully_passed?
  end

  def complited_tests_after_event_start
    event_start = Badge.find_by(rule: @rule, rule_value: @rule_value).updated_at
    TestPassage.where(current_question: nil, updated_at: event_start..Time.current)
  end
end
