class AddActiveToIdeas < ActiveRecord::Migration[5.0]
  def change
    add_column :ideas, :active, :integer, default: 0
  end
end
