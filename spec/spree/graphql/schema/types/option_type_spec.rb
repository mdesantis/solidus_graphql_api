# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::GraphQL::Schema::Types::OptionType do
  let(:variant) { create(:variant) }
  let(:option_value) { variant.option_values.first }
  let(:product) { variant.product }
  let(:option_type) { option_value.option_type }
  let(:ctx) {}
  let(:variables) {}

  describe 'fields' do
    let(:query) do
      %{
        query {
          productBySlug(slug: #{product.slug.to_json}) {
            variants {
              nodes {
                optionValues {
                  nodes {
                    optionType {
                      id
                      name
                      presentation
                    }
                  }
                }
              }
            }
          }
        }
      }
    end
    let(:result) do
      {
        data: {
          productBySlug: {
            variants: {
              nodes: [{
                optionValues: {
                  nodes: [{
                    optionType: {
                      id: Spree::GraphQL::Schema.id_from_object(option_type),
                      name: option_type.name,
                      presentation: option_type.presentation
                    }
                  }]
                }
              }]
            }
          }
        }
      }
    end

    it 'succeeds' do
      execute
      expect(response_hash).to eq(result_hash)
    end
  end
end
