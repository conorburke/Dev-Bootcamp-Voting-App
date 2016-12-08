class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :student_id
      t.integer :idea_id
      t.integer :round
      t.timestamps
    end
  end
end
