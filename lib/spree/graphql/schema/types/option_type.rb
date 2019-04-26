# frozen_string_literal: true

class Spree::GraphQL::Schema::Types::OptionType < Spree::GraphQL::Schema::Types::BaseObjectNode
  graphql_name 'OptionType'

  description 'TODO option type description'

  field :name, ::GraphQL::Types::String, null: false do
    description 'The option type’s name.'
  end
  def name
    object.name
  end

  field :presentation, ::GraphQL::Types::String, null: false do
    description 'The option type’s presentation.'
  end
  def presentation
    object.presentation
  end
end
