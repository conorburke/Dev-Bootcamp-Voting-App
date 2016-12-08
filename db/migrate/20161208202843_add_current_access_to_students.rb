class AddCurrentAccessToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :current_access, :string, default: ""
  end
end
