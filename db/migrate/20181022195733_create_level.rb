class CreateLevel < ActiveRecord::Migration[5.0]
  def change
    create_table :levels do |t|
      t.string :level_name
      t.integer :total_plays, default: 1
    end
  end
end
