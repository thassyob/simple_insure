class CreateInsuranceProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :insurance_profiles do |t|
      t.integer :age, null: false
      t.integer :dependents, null: false
      t.integer :income, null: false
      t.integer :marital_status, null: false
      t.boolean :risk_questions, array: true, null: false, default: [false, false, false]
      t.json :house, null: false, default: {}
      t.json :vehicle, null: false, default: {}

      t.timestamps
    end
  end
end
