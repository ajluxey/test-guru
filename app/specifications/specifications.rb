Dir[Rails.root.join('app', 'specifications', 'badges', '*.rb')].each { |file| require file }

module Specifications
  module Badges
    RULES = { first_try:                    { description: "Succesfully pass the test by first try",
                                              rule_checker: FirstTry },
              passed_all_tests_by_category: { description: "Successfully pass all tests by category",
                                              rule_checker: PassedAllTestsByCategory,
                                              select_arguements: [Category.all, :id, :title] },
              passed_all_tests_by_level:    { description: "Successfully pass all test with level",
                                              rule_checker: PassedAllTestsByLevel,
                                              select_arguements: [Test.all.pluck(:level).uniq, :to_s, :to_s] } }.freeze
  end
end
