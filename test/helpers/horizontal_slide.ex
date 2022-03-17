defmodule HorizontalSlide do
  use Hound.Helpers

  # Slide is in half steps, so every arrow_nudges will equal .5 in the result
  def precision_click_and_slide(arrow_nudges, direction) do
    move_to(slide_ele(), 0, 0)
    mouse_down(0)
    mouse_up(0)
    for _r <- 1..arrow_nudges, do: send_keys(String.to_atom("#{direction}_arrow"))
  end

  def slide_value_ele do
    find_element(:css, "span#range")
  end

  def slide_ele do
    find_element(:css, "div.sliderContainer input")
  end
end
