defmodule LargeAndDeepDOM do
  use Hound.Helpers
  use ExUnit.Case
  hound_session()

  # https://github.com/SeleniumHQ/selenium/issues/10447, Seems to be a bug in chromedriver 99 preventing smooth running here. Bad inspector message.

  @moduletag timeout: 4500
  setup do
    navigate_to("https://the-internet.herokuapp.com/large", 1)
    :ok
  end

  test "first on table" do
    row_and_column = [1, 1]
    parse_and_assert(row_and_column)
  end

  test "last on table" do
    row_and_column = [50, 50]
    parse_and_assert(row_and_column)
  end

  test "random on table" do
    row_and_column = [Enum.random(1..50), Enum.random(1..50)]
    parse_and_assert(row_and_column)
  end

  # This takes the row and column list, uses its parts as integers to find the element, and then compares the resulting string.
  def parse_and_assert(row_and_column) do
    row_enter = Enum.at(row_and_column, 0)
    column_enter = Enum.at(row_and_column, 1)
    grid_return = visible_text(row_and_column_ele(row_enter, column_enter))
    assert(grid_return == "#{Integer.to_string(row_enter)}.#{Integer.to_string(column_enter)}", "--- EXPECTED: #{row_and_column}, GOT: #{grid_return} INSTEAD. ---")
  end

  # This is a 50 X 50 grid. Pass in the row and column to pull the specified element.
  def row_and_column_ele(row, column) do
    find_element(:xpath, "//h4[text()='Siblings']") |> click()
    send_keys(:pagedown)
    find_element(:xpath, "//h4[text()='Table']")
    send_keys(:pagedown)
    #find_element(:css, "table#large-table tbody")
    find_element(:css, "tr.row-#{row} td.column-#{column}")
  end
end
