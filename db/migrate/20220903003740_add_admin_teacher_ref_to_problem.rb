class AddAdminTeacherRefToProblem < ActiveRecord::Migration[7.0]
  def change
    add_reference :problems, :admin_teacher, null: false, foreign_key: true
  end
end
