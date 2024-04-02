class AddUserIdToInsuranceProfiles < ActiveRecord::Migration[6.1]
  def change
    add_reference :insurance_profiles, :user, foreign_key: true
  end
end
