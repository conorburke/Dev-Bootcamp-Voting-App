class CreateRounds < ActiveRecord::Migration[5.0]
  def change
    create_table :rounds do |t|
      t.integer :voting_round, null: false, default: 1
      t.integer :cohort_id, null: false
      t.timestamps
    end
  end
end
