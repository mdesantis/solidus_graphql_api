# frozen_string_literal: true
module Spree::GraphQL::Types::ProductOption

  # name: The product option’s name.
  # @return [Types::String!]
  def name()
    object.presentation
  end

  # values: The corresponding value to the product option name.
  # @return [[Types::String!]!]
  def values()
    object.option_values.pluck :presentation
  end
end
