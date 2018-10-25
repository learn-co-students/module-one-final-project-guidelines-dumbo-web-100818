class CreateRunner < ActiveRecord::Migration[5.0]
  def change
      create_table :runners do |t|
        t.string :user_name
        t.string :color
        t.string :rank, :default "No Medal"
    end
  end
end
