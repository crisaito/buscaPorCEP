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
end
