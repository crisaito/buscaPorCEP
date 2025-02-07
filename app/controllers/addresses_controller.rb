# frozen_string_literal: true

class AddressesController < ApplicationController
  BASE_URL = "https://cep.awesomeapi.com.br/json/"

  def search
    @most_searched_ceps = Address.most_searched

    uri = URI("#{BASE_URL}#{params[:cep]}")
    response = Net::HTTP.get_response(uri)
    @address = JSON.parse(response.body)

    address_response(response)
  end

  private

  def address_response(response)
    if response.code == "200"
      save_address
      return @address
    end

    @error_message = @address["message"]
    @address = nil
  end

  def save_address
    Address.create!(
      cep: @address["cep"],
      city: @address["city"],
      state: @address["state"]
    )
  end
end
