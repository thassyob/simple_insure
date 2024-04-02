# frozen_string_literal: true

FactoryBot.define do
  factory :insurance_profile do
    age { 35 }
    dependents { 2 }
    income { 0 }
    marital_status { 'married' }
    risk_questions { [0, 1, 0] }
    house { { ownership_status: 'owned' } }
    vehicle { { year: 2018 } }
    user { nil }
  end
end
