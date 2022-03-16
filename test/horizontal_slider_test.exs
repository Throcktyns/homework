defmodule HorizontalSlider do
  use Hound.Helpers
  use ExUnit.Case
  hound_session()

  @moduletag timeout: 6000
  setup do
    navigate_to "https://the-internet.herokuapp.com/horizontal_slider"
    :ok
  end

  test "minimum slide while still sliding" do
    precision_click_and_slide(1, "right")
    assert_slide_value(visible_text(slide_value_ele()), "0.5")
  end

  test "maximum slide" do
    precision_click_and_slide(10, "right")
    assert_slide_value(visible_text(slide_value_ele()), "5")
  end

  test "random slide and back to starting line" do
    random_slide = Enum.random(1..10)
    precision_click_and_slide(random_slide, "right")
    precision_click_and_slide(random_slide, "left")
    assert_slide_value(visible_text(slide_value_ele()), "0")
  end

  test "mid slide with expected failure/screenshot" do
    precision_click_and_slide(5, "right")
    assert_slide_value(visible_text(slide_value_ele()), "20")
  end

  # Ideally these locator/helper functions would be in their own object file---
  # Slide is in half steps, so every arrow_nudges will equal .5 in the result
  def precision_click_and_slide(arrow_nudges, direction) do
    move_to(slide_ele(), 0, 0)
    mouse_down(0)
    mouse_up(0)
    for _r <- 1..arrow_nudges, do: send_keys(String.to_atom("#{direction}_arrow"))
  end

  def assert_slide_value(slide_value, expected) do
    try do
      assert(slide_value == expected)
    rescue
      error ->
        take_screenshot()
        raise error
    end
  end

  def slide_value_ele do
    find_element(:css, "span#range")
  end

  def slide_ele do
    find_element(:css, "div.sliderContainer input")
  end
end
