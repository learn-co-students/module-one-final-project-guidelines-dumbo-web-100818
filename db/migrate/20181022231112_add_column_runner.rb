class AddColumnRunner < ActiveRecord::Migration[5.0]
  def change
    add_column :runners, :total_points, :integer
  end
end
