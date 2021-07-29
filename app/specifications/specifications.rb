module Specification
  module Badges
    RULES = { first_try: FirstTryRule,
              passed_all_tests_by_category: PassedAllTestsByCategoryRule,
              passed_all_tests_by_level: PassedAllTestsByLevelRule }.freeze
    
    class FirstTryRule < AbstractBadgeRule
      def satisfied_with?(test_passage)
        if super(test_passage)
          TestPassage.where(user: test_passage.user, test: test_passage.test).count == 1
        else
          false
        end
      end
    end

    class PassedAllTestsByCategoryRule < PassedAllTestsBySomeRule
      def satisfied_with?(test_passage)
        # ниже подозрительная строка
        if @rule_value != test_passage.test.category
          super(test_passage, { test: Test.where(category: test_passage.test.category) })
        else
          false
        end
      end
    end

    class PassedAllTestsByLevelRule < PassedAllTestsBySomeRule
      def satisfied_with?
        if @rule_value.to_i != test_passage.test.level
          super(test_passage, { test: Test.where(level: @rule_value) })
        else
          false
        end
      end
    end
    
    private

    class AbstractBadgeRule
      def initialize(rule, rule_value)
        @rule = rule
        @rule_value = rule_value
      end

      def satisfied_with?(test_passage)
        test_passage.successfuly_passed?
      end
    end

    class PassedAllTestsBySomeRule < AbstractBadgeRule
      def satisfied_with?(test_passage, where_arguments)
        return false unless super

        event_start = Badges.find_by(rule: @rule, rule_value: @rule_value).updated_at
        test_passages_after_badge_update = TestPassage.where(user: test_passage.current_user,
                                                            current_question: nil,
                                                            updated_at: event_start..Time.current)
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
  end
end
