require "application_system_test_case"

class DailyNumerologiesTest < ApplicationSystemTestCase
  setup do
    @daily_numerology = daily_numerologies(:one)
  end

  test "visiting the index" do
    visit daily_numerologies_url
    assert_selector "h1", text: "Daily numerologies"
  end

  test "should create daily numerology" do
    visit daily_numerologies_url
    click_on "New daily numerology"

    fill_in "Affirmation", with: @daily_numerology.affirmation
    fill_in "Birth date", with: @daily_numerology.birth_date
    fill_in "Color", with: @daily_numerology.color
    fill_in "Gem", with: @daily_numerology.gem
    fill_in "Number", with: @daily_numerology.number
    fill_in "Word", with: @daily_numerology.word
    click_on "Create Daily numerology"

    assert_text "Daily numerology was successfully created"
    click_on "Back"
  end

  test "should update Daily numerology" do
    visit daily_numerology_url(@daily_numerology)
    click_on "Edit this daily numerology", match: :first

    fill_in "Affirmation", with: @daily_numerology.affirmation
    fill_in "Birth date", with: @daily_numerology.birth_date
    fill_in "Color", with: @daily_numerology.color
    fill_in "Gem", with: @daily_numerology.gem
    fill_in "Number", with: @daily_numerology.number
    fill_in "Word", with: @daily_numerology.word
    click_on "Update Daily numerology"

    assert_text "Daily numerology was successfully updated"
    click_on "Back"
  end

  test "should destroy Daily numerology" do
    visit daily_numerology_url(@daily_numerology)
    click_on "Destroy this daily numerology", match: :first

    assert_text "Daily numerology was successfully destroyed"
  end
end
