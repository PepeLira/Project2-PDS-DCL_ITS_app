class AddPasswordDigestToAdminTeachers < ActiveRecord::Migration[7.0]
  def change 
    add_column :admin_teachers, :password_digest, :string 
  end
end
