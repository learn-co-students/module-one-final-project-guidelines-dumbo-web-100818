class RemoveColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :runners, :total_points
  end
end
