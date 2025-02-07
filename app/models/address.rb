class Address < ApplicationRecord
  validates :cep, :city, :state, presence: true
  validates :cep, format: { with: /\A\d{8}\z/, message: "CEP invalido" }
end
