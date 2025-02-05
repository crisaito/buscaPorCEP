# frozen_string_literal: true

module V1
  class AddressesController < ApplicationController
    BASE_URL = "https://cep.awesomeapi.com.br/json/05424020"

    def search
      uri = URI(BASE_URL)
      address = Net::HTTP.get(uri)

      render json: address, status: :ok
    end
  end
end
