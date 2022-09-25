class RemovePasswordFromAdminTeachers < ActiveRecord::Migration[7.0]
  def change   
    remove_column :admin_teachers, :password    
  end
end