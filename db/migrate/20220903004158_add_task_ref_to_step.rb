class AddTaskRefToStep < ActiveRecord::Migration[7.0]
  def change
    add_reference :steps, :task, null: false, foreign_key: true
  end
end
