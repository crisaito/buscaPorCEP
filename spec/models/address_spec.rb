# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:cep) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:state) }

    context 'CEP' do
      it 'is valid when format is correct' do
        address = Address.new(cep: '12345678', city: 'São Paulo', state: 'SP')
        expect(address).to be_valid
      end

      it 'is invalid when less than 8 digits' do
        address = Address.new(cep: '1234567', city: 'São Paulo', state: 'SP')
        expect(address).not_to be_valid
      end

      it 'is invalid when more than 8 digits' do
        address = Address.new(cep: '123456789', city: 'São Paulo', state: 'SP')
        expect(address).not_to be_valid
      end
    end
  end

  describe 'scopes' do
    context '.most_searched' do
      before do
        10.times { Address.create(cep: '10002020', city: "São Paulo", state: "SP") }
        5.times { Address.create(cep: '51004014', city: "São Paulo", state: "SP") }
        11.times { Address.create(cep: '11031502', city: "São Paulo", state: "SP") }
        Address.create(cep: '00011122', city: "São Paulo", state: "SP")
      end

      it 'returns the 3 most searched ceps' do
        most_searched = Address.most_searched

        expect(most_searched.length).to eq(3)
        expect(most_searched.first.cep).to eq('11031502')
        expect(most_searched.first.cep_count).to eq(11)
        expect(most_searched.second.cep).to eq('10002020')
        expect(most_searched.second.cep_count).to eq(10)
        expect(most_searched.third.cep).to eq('51004014')
        expect(most_searched.third.cep_count).to eq(5)
        expect(most_searched.pluck(:cep)).not_to include("00011122")
      end
    end
  end
end
