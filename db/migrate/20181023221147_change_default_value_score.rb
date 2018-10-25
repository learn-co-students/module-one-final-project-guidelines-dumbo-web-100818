class ChangeDefaultValueScore < ActiveRecord::Migration[5.0]
  def change
    change_column_default( :scores, :scores, from: nil, to: 0)
  end
end
