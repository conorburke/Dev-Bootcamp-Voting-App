class CreateChoices < ActiveRecord::Migration[5.0]
  def change
    create_table :choices do |t|
      t.integer :student_id, null: false
      t.integer :idea_id, null: false
      t.integer :preference_level, null: false

      t.timestamps
    end
  end
end
