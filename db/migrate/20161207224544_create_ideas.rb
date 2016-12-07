class CreateIdeas < ActiveRecord::Migration[5.0]
  def change
    create_table :ideas do |t|
      t.string :title, null: false
      t.integer :student_id, null: false
      t.timestamps
    end
  end
end
