# frozen_string_literal: true
require 'spec_helper'

module Spree::GraphQL
  describe 'Mutations::CustomerAccessTokenCreate' do
    let(:ctx) { current_store }
    let(:mutation) do
      <<~GQL
        mutation test($input: CustomerAccessTokenCreateInput!) {
          customerAccessTokenCreate(input: $input) {
            customerAccessToken {
              accessToken
              expiresAt
            }
            customerUserErrors {
              code
              field
              message
            }
          }
        }
      GQL
    end

    context 'when the input email does not match with any authenticable user' do
      let(:variables) do
        {
          input: {
            email: 'not-existing-user@example.com',
            password: 'password'
          }
        }
      end
      let(:result) do
        {
          data: {
            customerAccessTokenCreate: {
              customerAccessToken: nil,
              customerUserErrors: [
                {
                  code: 'UNIDENTIFIED_CUSTOMER',
                  field: nil,
                  message: 'Unidentified customer'
                }
              ]
            }
          }
        }
      end

      it 'responds with an error' do
        execute(mutation)
        expect(response_hash).to eq(result_hash)
      end
    end

    context 'when the input email matches with an authenticable user but the input password is invalid' do
      let(:user) { create(:user) }
      let(:variables) do
        {
          input: {
            email: user.email,
            password: 'invalid-password'
          }
        }
      end
      let(:result) do
        {
          data: {
            customerAccessTokenCreate: {
              customerAccessToken: nil,
              customerUserErrors: [
                {
                  code: 'UNIDENTIFIED_CUSTOMER',
                  field: nil,
                  message: 'Unidentified customer'
                }
              ]
            }
          }
        }
      end

      it 'responds with an error' do
        execute(mutation)
        expect(response_hash).to eq(result_hash)
      end
    end

    context 'when the input email and the input password match with an authenticable user' do
      let(:user) { create(:user) }
      let(:variables) do
        {
          input: {
            email: user.email,
            password: user.password
          }
        }
      end
      let(:customer_access_token_response) { response_hash[:data][:customerAccessTokenCreate][:customerAccessToken] }

      it 'succeeds' do
        execute(mutation)
        expect(response_hash).to match a_hash_including({
          'data' => {
            'customerAccessTokenCreate' => {
              'customerAccessToken' => {
                'accessToken' => instance_of(String),
                'expiresAt' => instance_of(String)
              },
              'customerUserErrors' => []
            }
          }
        })
      end

      it 'responds with a correct accessToken value' do
        execute(mutation)
        access_token = customer_access_token_response[:accessToken]
        expect(SolidusJwt.decode(access_token).first).to match a_hash_including(
          'id' => user.id,
          'email' => user.email
        )
      end

      it 'responds with a correct expiresAt value' do
        execute(mutation)
        access_token = customer_access_token_response[:accessToken]
        expires_at = customer_access_token_response[:expiresAt]
        expect(DateTime.iso8601(expires_at).to_i).to eq SolidusJwt.decode(access_token).first['exp']
      end
    end
  end
end
