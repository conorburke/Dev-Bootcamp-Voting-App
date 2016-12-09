class ChangeStudentAccessDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:students, :current_access, "")
  end
end
