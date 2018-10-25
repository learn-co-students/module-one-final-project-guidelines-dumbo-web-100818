class CreateScore < ActiveRecord::Migration[5.0]
  def change
    create_table :scores do |t|
      t.integer :runner_id
      t.integer :level_id
      t.integer :score
    end
  end
end
