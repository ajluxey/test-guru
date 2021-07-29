module Specifications
  module Badges
    # RULES contain descriprions and classes that check implementations of the rules
    RULES = { first_try:                    { description: "Succesfully pass the test by first try",
                                              rule_checker: nil },
              passed_all_tests_by_category: { description: "Successfully pass all tests by category",
                                              rule_checker: nil },
              passed_all_tests_by_level:    { description: "Successfully pass all test with level",
                                              rule_checker: nil } }

    class AbstractRuleChecker
      def initialize(rule, rule_value)
        @rule = rule
        @rule_value = rule_value
      end

      def satisfied_with?(test_passage)
        test_passage.successfully_passed?
      end
    end

    class PassedAllTestsBySomeCondition < AbstractRuleChecker
      def satisfied_with?(test_passage, where_arguments)
        return false unless super

        event_start = Badges.find_by(rule: @rule, rule_value: @rule_value).updated_at
        test_passages_after_badge_update = TestPassage.where(user: test_passage.current_user,
                                                            current_question: nil,
                                                            updated_at: event_start..Time.current)
        # add scope to name
        test_passages_by_some_rule = test_passages_after_badge_update.where(where_arguments)
        if test_passages_by_some_rule.count > 0
          successfully_passed_counts = Array.new(0, test_passages_by_some_rule.count)
          test_passages_by_same_category.each_with_index do |tp, index|
            successfully_passed_counts[index] += 1 if tp.successfully_passed?
          end
          successfully_passed_counts.all
        else
          false
        end
      end
    end

    class FirstTry < AbstractRuleChecker
      def satisfied_with?(test_passage)
        if super(test_passage)
          TestPassage.where(user: test_passage.user, test: test_passage.test).count == 1
        else
          false
        end
      end
    end

    RULES[:first_try][:rule_checker] = FirstTry

    class PassedAllTestsByCategory < PassedAllTestsBySomeCondition
      def satisfied_with?(test_passage)
        # ниже подозрительная строка
        if @rule_value == test_passage.test.category.id
          super(test_passage, { test: Test.where(category: test_passage.test.category) })
        else
          false
        end
      end
    end

    RULES[:passed_all_tests_by_category][:rule_checker] = PassedAllTestsByCategory

    class PassedAllTestsByLevel < PassedAllTestsBySomeCondition
      def satisfied_with?
        if @rule_value.to_i != test_passage.test.level
          super(test_passage, { test: Test.where(level: @rule_value) })
        else
          false
        end
      end
    end

    RULES[:passed_all_tests_by_level][:rule_checker] = PassedAllTestsByLevel

    RULES.freeze
  end
end
