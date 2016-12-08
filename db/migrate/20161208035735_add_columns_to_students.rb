class AddColumnsToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :cohort_id, :integer
    add_column :students, :group_id, :integer
  end
end
