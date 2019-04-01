class Spree::GraphQL::Schema::Payloads::CheckoutCreate < Spree::GraphQL::Schema::Payloads::BasePayload
  graphql_name 'CheckoutCreatePayload'
  description %q{Return type for `checkoutCreate` mutation.}
  field :checkout, ::Spree::GraphQL::Schema::Types::Checkout, null: true do
    description %q{The new checkout object.}
  end
  field :user_errors, [::Spree::GraphQL::Schema::Types::CheckoutUserError], null: false, deprecation_reason: %q{Use `checkoutUserErrors` instead} do
    description %q{List of errors that occurred executing the mutation.}
  end
  field :checkout_user_errors, [::Spree::GraphQL::Schema::Types::CheckoutUserError], null: false do
    description %q{List of errors that occurred executing the mutation.}
  end
end
