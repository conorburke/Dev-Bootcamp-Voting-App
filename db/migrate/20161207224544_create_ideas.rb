class CreateIdeas < ActiveRecord::Migration[5.0]
  def change
    create_table :ideas do |t|
      t.string :title, null: false
      t.integer :creator_id, class_name: "Student"
      t.timestamps
    end
  end
end
