require "application_system_test_case"

class ProblemsTest < ApplicationSystemTestCase
  setup do
    @problem = problems(:one)
  end

  test "visiting the index" do
    visit problems_url
    assert_selector "h1", text: "Problems"
  end

  test "should create problem" do
    visit problems_url
    click_on "New problem"

    fill_in "Admin teacher", with: @problem.admin_teacher_id
    fill_in "Ball joint points", with: @problem.ball_joint_points
    fill_in "Con rod points", with: @problem.con_rod_points
    fill_in "Description", with: @problem.description
    fill_in "Extern joins points", with: @problem.extern_joins_points
    fill_in "Forces moments points", with: @problem.forces_moments_points
    fill_in "Structure", with: @problem.structure_id
    fill_in "Title", with: @problem.title
    click_on "Create Problem"

    assert_text "Problem was successfully created"
    click_on "Back"
  end

  test "should update Problem" do
    visit problem_url(@problem)
    click_on "Edit this problem", match: :first

    fill_in "Admin teacher", with: @problem.admin_teacher_id
    fill_in "Ball joint points", with: @problem.ball_joint_points
    fill_in "Con rod points", with: @problem.con_rod_points
    fill_in "Description", with: @problem.description
    fill_in "Extern joins points", with: @problem.extern_joins_points
    fill_in "Forces moments points", with: @problem.forces_moments_points
    fill_in "Structure", with: @problem.structure_id
    fill_in "Title", with: @problem.title
    click_on "Update Problem"

    assert_text "Problem was successfully updated"
    click_on "Back"
  end

  test "should destroy Problem" do
    visit problem_url(@problem)
    click_on "Destroy this problem", match: :first

    assert_text "Problem was successfully destroyed"
  end
end
