class AlterGoalsIntegerFields < ActiveRecord::Migration
  def change
    change_column :goals, :completed, :bigint
    change_column :goals, :finish_time, :bigint
  end
end
