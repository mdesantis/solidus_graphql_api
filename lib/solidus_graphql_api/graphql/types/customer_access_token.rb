# frozen_string_literal: true
module Spree::GraphQL::Types::CustomerAccessToken

  # accessToken: The customer’s access token.
  # @return [Types::String!]
  def access_token()
    object[:access_token]
  end

  # expiresAt: The date and time when the customer access token expires.
  # @return [Types::DateTime!]
  def expires_at()
    object[:expires_at]
  end
end
