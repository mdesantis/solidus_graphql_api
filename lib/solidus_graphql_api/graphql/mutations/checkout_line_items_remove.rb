# frozen_string_literal: true
class Spree::GraphQL::Mutations::CheckoutLineItemsRemove < Spree::GraphQL::Mutations::BaseMutation
  payload_type ::Spree::GraphQL::Schema::Payloads::CheckoutLineItemsRemove
  description %q{Removes line items from an existing checkout}
  argument :line_item_ids, [::GraphQL::Types::ID], required: true, description: %q{line item ids to remove}
  argument :checkout_id, ::GraphQL::Types::ID, required: true, description: %q{the checkout on which to remove line items}

  def resolve(checkout_id:, line_item_ids:)
    order = object_from_id nil, checkout_id, context

    order.class.transaction do
      line_item_ids.each do |graphql_id|
        line_item = object_from_id nil, graphql_id, context

        order.contents.remove_line_item line_item
      end
    end

    {
      checkout: order.reload,
      user_errors: []
    }
  end
end
