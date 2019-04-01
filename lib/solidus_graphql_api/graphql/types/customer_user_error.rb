# frozen_string_literal: true
module Spree::GraphQL::Types::CustomerUserError
  include ::Spree::GraphQL::Interfaces::DisplayableError

  # code: Error code to uniquely identify the error.
  # @return [Types::CustomerErrorCode]
  def code()
    object[:code]
  end

  # field: Path to the input field which caused the error.
  # @return [[Types::String!]]
  def field()
    object[:field]
  end

  # message: The error message.
  # @return [Types::String!]
  def message()
    object[:message]
  end
end
