# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InsuranceProfile, type: :model do
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:age) }
  it { is_expected.to validate_presence_of(:dependents) }
  it { is_expected.to validate_presence_of(:income) }
  it { is_expected.to validate_presence_of(:marital_status) }
  it { is_expected.to validate_presence_of(:risk_questions) }
  it { is_expected.to validate_presence_of(:house) }
  it { is_expected.to validate_presence_of(:vehicle) }

  it { is_expected.to define_enum_for(:marital_status).with_values(single: 0, married: 1) }

  it 'validates ownership_status enum within house' do
    user = create(:user)
    profile = create(:insurance_profile, user:)

    expect(profile.house[:ownership_status]).to eq('owned')
  end
end
