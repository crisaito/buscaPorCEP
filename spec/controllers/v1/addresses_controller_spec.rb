# frozen_string_literal: true

require 'rails_helper'

describe 'Addresses', type: :request do
  let(:base_url) { "https://cep.awesomeapi.com.br/json/#{cep}" }

  describe '#search' do
    let(:cep) { '05424020' }
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

    context 'when the cep is valid' do
      before do
        stub_request(:get, base_url)
          .to_return(
            status: 200,
            body: address_response.to_json,
          )
      end

      it 'returns a successful response with the address' do
        get v1_addresses_path(cep)

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body, symbolize_names: true)).to eq(address_response)
      end
    end

    context 'when the cep is invalid' do
      let(:cep) { '02020' }
      let(:address_invalid_response) do
        {
          "code": "invalid",
          "message": "CEP invalido, tente: 00000000"
        }
      end

      before do
        stub_request(:get, base_url)
          .to_return(
            status: 400,
            body: address_invalid_response.to_json,
          )
      end

      it 'returns bad request' do
        get v1_addresses_path(cep)

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body, symbolize_names: true)).to eq({"erro": address_invalid_response[:message]})
      end
    end

    context 'when the cep is not found' do
      let(:cep) { '09090909' }
      let(:address_not_found_response) do
        {
          "code": "not_found",
          "message": "O CEP 09090909 nao foi encontrado"
        }
      end

      before do
        stub_request(:get, base_url)
          .to_return(
            status: 404,
            body: address_not_found_response.to_json,
          )
      end

      it 'returns not found' do
        get v1_addresses_path(cep)

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body, symbolize_names: true)).to eq({"erro": address_not_found_response[:message]})
      end
    end
  end
end
