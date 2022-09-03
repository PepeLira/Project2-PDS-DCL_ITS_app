class AddProblemRefToTask < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :problem, null: false, foreign_key: true
  end
end
