# frozen_string_literal: true
class Spree::GraphQL::Mutations::CheckoutCreate < Spree::GraphQL::Mutations::BaseMutation
  payload_type ::Spree::GraphQL::Schema::Payloads::CheckoutCreate
  description %q{Creates a new checkout.}
  argument :input, ::Spree::GraphQL::Schema::Inputs::CheckoutCreate, required: true, description: nil

  def resolve(input:)
    order = Spree::Order.create

    raise ::Spree::GraphQL::NotImplementedError.new if order.new_record?

    {
      checkout: order,
      user_errors: [],
      checkout_user_errors: []
    }
  end
end
