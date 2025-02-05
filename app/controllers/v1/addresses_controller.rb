# frozen_string_literal: true

module V1
  class AddressesController < ApplicationController
    BASE_URL = "https://cep.awesomeapi.com.br/json/"

    def search
      uri = URI("#{BASE_URL}#{params[:cep]}")
      address = Net::HTTP.get(uri)

      render json: address, status: :ok
    end
  end
end
