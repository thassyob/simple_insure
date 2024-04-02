# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InsuranceProfileCalculatorService do
  describe '#calculate_profile' do
    let(:user) { create(:user) }
    let(:service) { described_class.new(insurance_profile.id) }
    let(:insurance_profile) { create(:insurance_profile, user:) }

    subject(:calculate_profile) { service.calculate_profile }

    context 'when user has low risk' do
      before do
        insurance_profile.update!(income: 300_000)
      end

      it 'returns insurance profiles with economic status' do
        expect(calculate_profile).to eq(
          auto: 'padrao',
          disability: 'avancado',
          home: 'padrao',
          life: 'avancado'
        )
      end
    end

    context 'when user has high risk' do
      before do
        insurance_profile.update!(age: 60)
      end

      it 'returns insurance profiles with advanced status' do
        expect(calculate_profile).to eq(
          auto: 'padrao',
          disability: 'inelegivel',
          home: 'padrao',
          life: 'avancado'
        )
      end
    end
  end
end
