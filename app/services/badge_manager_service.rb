class BadgeManagerService
  def self.call(test_passage)
    self.new(test_passage)
  end

  def initialize(test_passage)
    @test_passage = test_passage
    check_and_award
  end

  private

  def check_and_award
    Badge.all.each do |badge|
      rule_checker = Specifications::Badges::RULES[badge.rule][:rule_checker].new(badge.rule, badge.rule_value)
      @test_passage.user.badges << badge if rule_checker.satisfied_with?(@test_passage) 
    end
  end
end
