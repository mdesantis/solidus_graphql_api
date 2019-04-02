# frozen_string_literal: true
class Spree::GraphQL::Mutations::CheckoutLineItemsUpdate < Spree::GraphQL::Mutations::BaseMutation
  payload_type ::Spree::GraphQL::Schema::Payloads::CheckoutLineItemsUpdate
  description %q{Updates line items on a checkout.}
  argument :line_items, [::Spree::GraphQL::Schema::Inputs::CheckoutLineItemUpdate], required: true, description: %q{line items to update.}
  argument :checkout_id, ::GraphQL::Types::ID, required: true, description: %q{the checkout on which to update line items.}

  def resolve(checkout_id:, line_items:)
    order = object_from_id nil, checkout_id, context

    order.class.transaction do
      line_items.each do |graphql_line_item|
        line_item = object_from_id nil, graphql_line_item[:id], context
        quantity = graphql_line_item[:quantity]

        cart_updated = order.contents.update_cart(
          {
            line_items_attributes: {
              id: line_item.id,
              quantity: quantity,
              options: {}
            }
          }
        )

        raise ::Spree::GraphQL::NotImplementedError.new unless cart_updated
      end
    end

    {
      checkout: order.reload,
      user_errors: []
    }
  end
end
