require_relative 'abstract_rule_checker'

class FirstTry < AbstractRuleChecker
  def satisfied_with?(test_passage)
    if super(test_passage)
      TestPassage.where(user: test_passage.user, test: test_passage.test).count == 1
    else
      false
    end
  end
end
