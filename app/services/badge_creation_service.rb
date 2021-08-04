module BadgeCreationService
  Rule = Struct.new(:key, :description, :select_arguements)

  def self.rules_collection
    Specifications::Badges::RULES.map { |key, value| Rule.new(key, value[:description], value[:select_arguements]) }
  end

  def self.badge_params(params)
    badge_params_for_controller = params.require(:badge)
    rule = badge_params_for_controller[:rule]
    if rule.present?
      badge_params_for_controller[:rule_value] = badge_params_for_controller.delete(rule) 
      badge_params_for_controller[:description] = "#{Specifications::Badges::RULES[rule.to_sym][:description]} #{badge_params_for_controller[:rule_value]}" 
    end
    badge_params_for_controller.permit(:title, :description, :rule, :rule_value, :image_path)
  end
end
