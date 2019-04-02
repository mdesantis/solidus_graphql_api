# frozen_string_literal: true
module Spree::GraphQL::Types::SelectedOption

  # name: The product option’s name.
  # @return [Types::String!]
  def name()
    object.option_type.presentation
  end

  # value: The product option’s value.
  # @return [Types::String!]
  def value()
    object.presentation
  end
end
