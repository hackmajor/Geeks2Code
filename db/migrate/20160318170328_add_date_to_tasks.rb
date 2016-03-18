class AddDateToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :completition_date, :date
  end
end
