# frozen_string_literal: true

class AddressesController < ApplicationController
  BASE_URL = "https://cep.awesomeapi.com.br/json/"

  def search
    uri = URI("#{BASE_URL}#{params[:cep]}")
    response = Net::HTTP.get_response(uri)
    @address = JSON.parse(response.body)

    address_response(response)
  end

  private

  def address_response(response)
    return @address if response.code == "200"

    @error_message = @address["message"]
    @address = nil
  end
end
