require "application_system_test_case"

class StructuresTest < ApplicationSystemTestCase
  setup do
    @structure = structures(:one)
  end

  test "visiting the index" do
    visit structures_url
    assert_selector "h1", text: "Structures"
  end

  test "should create structure" do
    visit structures_url
    click_on "New structure"

    fill_in "Admin teacher", with: @structure.admin_teacher_id
    fill_in "Moment reference", with: @structure.moment_reference
    click_on "Create Structure"

    assert_text "Structure was successfully created"
    click_on "Back"
  end

  test "should update Structure" do
    visit structure_url(@structure)
    click_on "Edit this structure", match: :first

    fill_in "Admin teacher", with: @structure.admin_teacher_id
    fill_in "Moment reference", with: @structure.moment_reference
    click_on "Update Structure"

    assert_text "Structure was successfully updated"
    click_on "Back"
  end

  test "should destroy Structure" do
    visit structure_url(@structure)
    click_on "Destroy this structure", match: :first

    assert_text "Structure was successfully destroyed"
  end
end
