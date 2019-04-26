# frozen_string_literal: true

class Spree::GraphQL::Schema::Types::OptionValue < Spree::GraphQL::Schema::Types::BaseObjectNode
  graphql_name 'OptionValue'

  description 'TODO option value description'

  field :name, ::GraphQL::Types::String, null: false do
    description 'The option value’s name.'
  end
  def name
    object.name
  end

  field :option_type, ::Spree::GraphQL::Schema::Types::OptionType, null: false do
    description 'The option value’s option type.'
  end
  def option_type
    object.option_type
  end

  field :presentation, ::GraphQL::Types::String, null: false do
    description 'The option value’s presentation.'
  end
  def presentation
    object.presentation
  end
end
