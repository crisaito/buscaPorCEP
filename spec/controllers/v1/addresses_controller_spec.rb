# frozen_string_literal: true

require 'rails_helper'

describe 'Addresses', type: :request do
  let(:base_url) { 'https://cep.awesomeapi.com.br/json/05424020' }
  let(:address_response) do
    {
      'cep': '05424020',
      'address_type': 'Rua',
      'address_name': 'Professor Carlos Reis',
      'address': 'Rua Professor Carlos Reis',
      'state': 'SP',
      'district': 'Pinheiros',
      'lat': '-23.5703281',
      'lng': '-46.6967126',
      'city': 'São Paulo',
      'city_ibge': '3550308',
      'ddd': '11'
    }
  end

  describe '#search' do
    context 'when the request is successful' do
      before do
        stub_request(:get, base_url)
          .to_return(
            status: 200,
            body: address_response.to_json,
          )
      end

      it 'returns a successful response with the address' do
        get v1_addresses_path

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body, symbolize_names: true)).to eq(address_response)
      end
    end
  end
end
