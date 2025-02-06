# frozen_string_literal: true

module V1
  class AddressesController < ApplicationController
    BASE_URL = "https://cep.awesomeapi.com.br/json/"

    def search
      uri = URI("#{BASE_URL}#{params[:cep]}")
      response = Net::HTTP.get_response(uri)
      address = JSON.parse(response.body)

      case response.code
      when "200"
        render json: address, status: :ok
      when "400"
        render json: { erro: address["message"] }, status: :bad_request
      when "404"
        render json: { erro: address["message"] }, status: :not_found
      end
    end
  end
end
