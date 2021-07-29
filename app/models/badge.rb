class Badge < ApplicationRecord
  has_and_belongs_to_many :users, join_table: :users_badges

  validates :title, presence: true
  validates :description, presence: true
  validates :rule, presence: true
  validate  :validate_rule_is_available
  # validates :image_path, presence: true, format: { with: /*/ }

  def self.available_rules
    Specifications::Badges::RULES.keys
  end

  def rule
    attributes['rule']&.to_sym
  end

  private
  
  def validate_rule_is_available
    errors.add(:rule, "is not available") if !rule.in? self.class.available_rules
  end
end
