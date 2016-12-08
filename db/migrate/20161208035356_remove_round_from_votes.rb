class RemoveRoundFromVotes < ActiveRecord::Migration[5.0]
  def change
    remove_column :votes, :round, :integer
  end
end
