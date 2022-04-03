defmodule HorizontalSlider do
  use Hound.Helpers
  use ExUnit.Case
  alias HorizontalSlide, as: HSlide
  hound_session()

  @moduletag timeout: 6000
  setup do
    navigate_to "https://the-internet.herokuapp.com/horizontal_slider"
    :ok
  end

  test "minimum slide while still sliding" do
    HSlide.precision_click_and_slide(1, "right")
    assert_slide_value(visible_text(HSlide.slide_value_ele()), "0.5")
  end

  test "maximum slide" do
    HSlide.precision_click_and_slide(10, "right")
    assert_slide_value(visible_text(HSlide.slide_value_ele()), "5")
  end

  test "random slide and back to starting line" do
    random_slide = Enum.random(1..10)
    HSlide.precision_click_and_slide(random_slide, "right")
    HSlide.precision_click_and_slide(random_slide, "left")
    assert_slide_value(visible_text(HSlide.slide_value_ele()), "0")
  end

  test "mid slide with expected failure/screenshot" do
    HSlide.precision_click_and_slide(5, "right")
    assert_slide_value(visible_text(HSlide.slide_value_ele()), "25")
  end

  # Pulled these tests' assert out to add screenshot on failure, but it's a little funky.
  def assert_slide_value(slide_value, expected) do
    try do
      assert(slide_value == expected)
    rescue
      error ->
        take_screenshot()
        raise error
    end
  end
end
