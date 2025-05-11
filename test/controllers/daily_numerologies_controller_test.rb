require "test_helper"

class DailyNumerologiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @daily_numerology = daily_numerologies(:one)
  end

  test "should get index" do
    get daily_numerologies_url
    assert_response :success
  end

  test "should get new" do
    get new_daily_numerology_url
    assert_response :success
  end

  test "should create daily_numerology" do
    assert_difference("DailyNumerology.count") do
      post daily_numerologies_url, params: { daily_numerology: { affirmation: @daily_numerology.affirmation, birth_date: @daily_numerology.birth_date, color: @daily_numerology.color, gem: @daily_numerology.gem, number: @daily_numerology.number, word: @daily_numerology.word } }
    end

    assert_redirected_to daily_numerology_url(DailyNumerology.last)
  end

  test "should show daily_numerology" do
    get daily_numerology_url(@daily_numerology)
    assert_response :success
  end

  test "should get edit" do
    get edit_daily_numerology_url(@daily_numerology)
    assert_response :success
  end

  test "should update daily_numerology" do
    patch daily_numerology_url(@daily_numerology), params: { daily_numerology: { affirmation: @daily_numerology.affirmation, birth_date: @daily_numerology.birth_date, color: @daily_numerology.color, gem: @daily_numerology.gem, number: @daily_numerology.number, word: @daily_numerology.word } }
    assert_redirected_to daily_numerology_url(@daily_numerology)
  end

  test "should destroy daily_numerology" do
    assert_difference("DailyNumerology.count", -1) do
      delete daily_numerology_url(@daily_numerology)
    end

    assert_redirected_to daily_numerologies_url
  end
end
