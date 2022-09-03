class CreateAdminTeachers < ActiveRecord::Migration[7.0]
  def change
    create_table :admin_teachers do |t|
      t.string :full_name
      t.string :password

      t.timestamps
    end
  end
end
