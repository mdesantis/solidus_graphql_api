# frozen_string_literal: true
class Spree::GraphQL::Mutations::CustomerAccessTokenCreate < Spree::GraphQL::Mutations::BaseMutation
  payload_type ::Spree::GraphQL::Schema::Payloads::CustomerAccessTokenCreate
  description %q{Creates a customer access token. The customer access token is required to modify the customer object in any way.}
  argument :input, ::Spree::GraphQL::Schema::Inputs::CustomerAccessTokenCreate, required: true, description: nil

  CUSTOMER_USER_ERRORS = {
    UNIDENTIFIED_CUSTOMER: {
      code: 'UNIDENTIFIED_CUSTOMER',
      field: nil,
      message: 'Unidentified customer'
    },
  }.freeze

  def resolve(input:)
    user = Spree.user_class.find_for_authentication(email: input.email)
    return unidentified_customer_response unless user

    valid_password = user.valid_password?(input.password)
    return unidentified_customer_response unless valid_password

    token = user.generate_jwt_token expires_in: token_expires_in
    {
      customer_access_token: {
        access_token: token,
        expires_at: token_expires_at(token)
      },
      customer_user_errors: [],
      user_errors: []
    }
  end

  protected

  def token_expires_in
    SolidusJwt::Config.preferences[:jwt_expiration]
  end

  def token_expires_at(token)
    Time.at(SolidusJwt.decode(token).first['exp'].to_i).to_datetime
  end

  def unidentified_customer_response
    {
      customer_access_token: nil,
      customer_user_errors: [CUSTOMER_USER_ERRORS[:UNIDENTIFIED_CUSTOMER]],
      user_errors: [CUSTOMER_USER_ERRORS[:UNIDENTIFIED_CUSTOMER]]
    }
  end
end
