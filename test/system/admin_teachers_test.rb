require "application_system_test_case"

class AdminTeachersTest < ApplicationSystemTestCase
  setup do
    @admin_teacher = admin_teachers(:one)
  end

  test "visiting the index" do
    visit admin_teachers_url
    assert_selector "h1", text: "Admin teachers"
  end

  test "should create admin teacher" do
    visit admin_teachers_url
    click_on "New admin teacher"

    fill_in "Full name", with: @admin_teacher.full_name
    fill_in "Password", with: @admin_teacher.password
    click_on "Create Admin teacher"

    assert_text "Admin teacher was successfully created"
    click_on "Back"
  end

  test "should update Admin teacher" do
    visit admin_teacher_url(@admin_teacher)
    click_on "Edit this admin teacher", match: :first

    fill_in "Full name", with: @admin_teacher.full_name
    fill_in "Password", with: @admin_teacher.password
    click_on "Update Admin teacher"

    assert_text "Admin teacher was successfully updated"
    click_on "Back"
  end

  test "should destroy Admin teacher" do
    visit admin_teacher_url(@admin_teacher)
    click_on "Destroy this admin teacher", match: :first

    assert_text "Admin teacher was successfully destroyed"
  end
end
