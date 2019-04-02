# frozen_string_literal: true
class Spree::GraphQL::Mutations::CheckoutLineItemsAdd < Spree::GraphQL::Mutations::BaseMutation
  payload_type ::Spree::GraphQL::Schema::Payloads::CheckoutLineItemsAdd
  description %q{Adds a list of line items to a checkout.}
  argument :line_items, [::Spree::GraphQL::Schema::Inputs::CheckoutLineItem], required: true, description: %q{A list of line item objects to add to the checkout.}
  argument :checkout_id, ::GraphQL::Types::ID, required: true, description: %q{The ID of the checkout.}

  def resolve(checkout_id:, line_items:)
    order = object_from_id nil, checkout_id, context

    order.class.transaction do
      line_items.each do |graphql_line_item|
        variant = object_from_id nil, graphql_line_item[:variant_id], context
        quantity = graphql_line_item[:quantity]

        line_item = order.contents.add variant, quantity

        raise ::Spree::GraphQL::NotImplementedError.new if line_item.errors.present?
      end
    end

    {
      checkout: order.reload,
      user_errors: []
    }
  end
end
