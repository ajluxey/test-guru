class BadgeManagerService
  def self.call(test_passage)
    self.new(test_passage)
  end

  def initialize(test_passage)
    @test_passage = test_passage
  end

  private

  def check_and_award
    Badge.all.each do |badge|
      rule_checker = Specifications::Badges::RULES[badge.rule].call(@test_passage, badge.rule, badge.rule_value)
      current_user.badges << badge if rule_checker.satisfied_with?(@test_passage) 
    end
  end
end
