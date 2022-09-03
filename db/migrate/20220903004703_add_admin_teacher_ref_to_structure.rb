class AddAdminTeacherRefToStructure < ActiveRecord::Migration[7.0]
  def change
    add_reference :structures, :admin_teacher, null: false, foreign_key: true
  end
end
