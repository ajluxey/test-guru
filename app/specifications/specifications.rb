module Specifications
  module Badges
    RULES = { first_try:                    { description: "Succesfully pass the test by first try" },
              passed_all_tests_by_category: { description: "Successfully pass all tests by category",
                                              select_arguements: [Category.all, :id, :title] },
              passed_all_tests_by_level:    { description: "Successfully pass all test with level",
                                              select_arguements: [Test.all.pluck(:level).uniq, :to_s, :to_s] } }

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
        if @rule_value.to_i == test_passage.test.category.id
          super(test_passage, { test: Test.where(category: test_passage.test.category) })
        else
          false
        end
      end
    end

    RULES[:passed_all_tests_by_category][:rule_checker] = PassedAllTestsByCategory

    class PassedAllTestsByLevel < PassedAllTestsBySomeCondition
      def satisfied_with?(test_passage)
        if @rule_value.to_i == test_passage.test.level
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
