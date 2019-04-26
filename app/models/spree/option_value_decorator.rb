# frozen_string_literal: true

module SolidusGraphqlApi::OptionValueDecorator
  module ClassMethods
    def ransortable_attributes(_auth_object = nil)
      (super || []) | %w[position]
    end
  end

  def self.prepended(base)
    class << base
      prepend ClassMethods
    end
  end

  Spree::OptionValue.prepend self
end
