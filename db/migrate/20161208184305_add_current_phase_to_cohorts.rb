class AddCurrentPhaseToCohorts < ActiveRecord::Migration[5.0]
  def change
    add_column :cohorts, :current_phase, :string, default: "ideas"
  end
end
