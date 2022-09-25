class AddEmailToAdminTeachers < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_teachers, :email, :string
  end
end
