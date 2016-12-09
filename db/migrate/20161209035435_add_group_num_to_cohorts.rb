class AddGroupNumToCohorts < ActiveRecord::Migration[5.0]
  def change
    add_column :cohorts, :group_num, :integer
  end
end
