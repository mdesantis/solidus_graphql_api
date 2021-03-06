# frozen_string_literal: true

class Spree::GraphQL::Schema::Types::DateTime < GraphQL::Types::ISO8601DateTime
  description %q{An ISO-8601 encoded UTC date time string.}
end
