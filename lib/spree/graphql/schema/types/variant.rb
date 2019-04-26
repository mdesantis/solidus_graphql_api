# frozen_string_literal: true

class Spree::GraphQL::Schema::Types::Variant < Spree::GraphQL::Schema::Types::BaseObjectNode
  graphql_name 'Variant'

  description %q{A product variant represents a different version of a product, such as differing sizes or differing colors.}

  field :available_for_sale, ::GraphQL::Types::Boolean, null: false do
    description %q{Indicates if the product variant is available for sale.}
  end
  def available_for_sale
    raise ::Spree::GraphQL::NotImplementedError
  end

  field :images, ::Spree::GraphQL::Schema::Types::Image.connection_type, null: false do
    description 'The product variant’s images.'
    argument :query,
             [Spree::GraphQL::Schema::Inputs::RansackQuery],
             required: false,
             default_value: [{ 'key' => 's', 'value' => 'position asc' }],
             description: 'List of Ransack queries, can be used to filter and sort the results.'
  end
  def images(query:)
    query = Spree::GraphQL::Schema::Inputs::RansackQuery.queries_to_ransack_query(query)
    object.images.ransack(query).result
  end

  field :is_master, ::GraphQL::Types::Boolean, null: false, resolver_method: :master? do
    description 'Indicates if the product variant is the master variant.'
  end
  def master?
    object.is_master?
  end

  field :option_values, ::Spree::GraphQL::Schema::Types::OptionValue.connection_type, null: false do
    description 'The product variant’s option values.'
    argument :query,
             [Spree::GraphQL::Schema::Inputs::RansackQuery],
             required: false,
             default_value: [{ 'key' => 's', 'value' => 'position asc' }],
             description: 'List of Ransack queries, can be used to filter and sort the results.'
  end
  def option_values(query:)
    query = Spree::GraphQL::Schema::Inputs::RansackQuery.queries_to_ransack_query(query)
    object.option_values.ransack(query).result
  end

  field :price, ::Spree::GraphQL::Schema::Types::Money, null: false do
    description 'The product variant’s price.'
  end
  def price
    object.price_for(context[:helpers].current_pricing_options)
  end

  field :product, ::Spree::GraphQL::Schema::Types::Product, null: false do
    description %q{The product object that the product variant belongs to.}
  end
  def product
    object.product
  end

  field :sku, ::GraphQL::Types::String, null: true do
    description %q{The SKU (stock keeping unit) associated with the variant.}
  end
  def sku
    object.sku
  end

  field :title, ::GraphQL::Types::String, null: false do
    description %q{The product variant’s title.}
  end
  def title
    object.name
  end

  field :weight, ::GraphQL::Types::Float, null: true do
    description %q{The weight of the product variant in the unit system specified with `weight_unit`.}
  end
  def weight
    object.weight
  end
end
