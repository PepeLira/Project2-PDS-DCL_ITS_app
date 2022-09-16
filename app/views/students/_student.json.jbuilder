json.extract! student, :id, :email, :full_name, :password, :extern_joins_stat, :forces_moments_stat, :con_rod_stat, :ball_joint_stat, :created_at, :updated_at
json.url student_url(student, format: :json)
