class Address < ApplicationRecord
  validates :cep, :city, :state, presence: true
  validates :cep, format: { with: /\A\d{8}\z/, message: "CEP invalido" }

  scope :most_searched, -> {
    select("cep, COUNT(*) as cep_count")
      .group(:cep)
      .order("cep_count DESC")
      .limit(3)
  }

  scope :most_searched_by_state, -> {
    select("state, COUNT(*) as cep_count")
      .group(:state)
      .order("state, cep_count DESC")
      .limit(3)
  }
end
