class AddStudentRefToTask < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :student, null: false, foreign_key: true
  end
end
