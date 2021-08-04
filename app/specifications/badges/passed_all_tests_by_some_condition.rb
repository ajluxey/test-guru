require_relative 'abstract_rule_checker'

class PassedAllTestsBySomeCondition < AbstractRuleChecker
  def satisfied_with?(test_passage, where_arguments)
    return false unless super(test_passage)
    
    successfully_passed_counts = Hash[where_arguments[:test].collect { |test| [test.id, 0]}]
    where_arguments.merge!(user: test_passage.user)
    complited_tests_by_some_rule = complited_tests_after_event_start.where(where_arguments)
    if complited_tests_by_some_rule.count > 0
      complited_tests_by_some_rule.each do |tp|
        successfully_passed_counts[tp.test.id] += 1 if tp.successfully_passed?
      end
      user_this_badge_count = test_passage.user.badges.where(rule: @rule).count
      successfully_passed_counts.values.all? { |count| count - user_this_badge_count > 0 }
    else
      false
    end
  end
end

