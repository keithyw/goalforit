class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :goal
      t.integer :completed
      t.references :category, index: true
      t.text :description
      t.boolean :is_recurring
      t.integer :finish_time

      t.timestamps
    end
  end
end
