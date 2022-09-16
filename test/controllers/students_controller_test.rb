require "test_helper"

class StudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student = students(:one)
  end

  test "should get index" do
    get students_url
    assert_response :success
  end

  test "should get new" do
    get new_student_url
    assert_response :success
  end

  test "should create student" do
    assert_difference("Student.count") do
      post students_url, params: { student: { ball_joint_stat: @student.ball_joint_stat, con_rod_stat: @student.con_rod_stat, email: @student.email, extern_joins_stat: @student.extern_joins_stat, forces_moments_stat: @student.forces_moments_stat, full_name: @student.full_name, password: @student.password } }
    end

    assert_redirected_to student_url(Student.last)
  end

  test "should show student" do
    get student_url(@student)
    assert_response :success
  end

  test "should get edit" do
    get edit_student_url(@student)
    assert_response :success
  end

  test "should update student" do
    patch student_url(@student), params: { student: { ball_joint_stat: @student.ball_joint_stat, con_rod_stat: @student.con_rod_stat, email: @student.email, extern_joins_stat: @student.extern_joins_stat, forces_moments_stat: @student.forces_moments_stat, full_name: @student.full_name, password: @student.password } }
    assert_redirected_to student_url(@student)
  end

  test "should destroy student" do
    assert_difference("Student.count", -1) do
      delete student_url(@student)
    end

    assert_redirected_to students_url
  end
end
