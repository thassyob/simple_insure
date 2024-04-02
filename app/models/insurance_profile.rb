# frozen_string_literal: true

class InsuranceProfile < ApplicationRecord
  belongs_to :user

  validates :age, :dependents, :income, :marital_status, :risk_questions, :house, :vehicle, presence: true

  enum marital_status: { single: 0, married: 1 }
  enum ownership_status: { owned: 0, rented: 1 }

  store :house, accessors: [:ownership_status], coder: JSON
end
