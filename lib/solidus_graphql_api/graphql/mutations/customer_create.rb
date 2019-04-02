# frozen_string_literal: true
class Spree::GraphQL::Mutations::CustomerCreate < Spree::GraphQL::Mutations::BaseMutation
  payload_type ::Spree::GraphQL::Schema::Payloads::CustomerCreate
  description %q{Creates a new customer.}
  argument :input, ::Spree::GraphQL::Schema::Inputs::CustomerCreate, required: true, description: nil

  def resolve(input:)
    user = Spree::User.create(
      email: input.email,
      password: input.password,
      password_confirmation: input.password
    )

    raise ::Spree::GraphQL::NotImplementedError.new if user.new_record?

    {
      customer: user,
      user_errors: [],
      customer_user_errors: []
    }
  end
end
