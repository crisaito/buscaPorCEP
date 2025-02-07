# frozen_string_literal: true

class AddressesController < ApplicationController
  BASE_URL = "https://cep.awesomeapi.com.br/json/"

  def search
    uri = URI("#{BASE_URL}#{params[:cep]}")
    response = Net::HTTP.get_response(uri)
    @address = JSON.parse(response.body)

    address_response(response)

    @most_searched_ceps = Address.most_searched
    @most_searched_by_state = most_searched_by_state
    @total_searched_by_state = total_searched_by_state
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

  def most_searched_by_state
    Address.searched_by_state.group_by(&:state).transform_values(&:first)
  end

  def total_searched_by_state
    Address.searched_by_state.group_by(&:state).transform_values do |addresses|
      addresses.sum(&:cep_count)
    end
  end
end
