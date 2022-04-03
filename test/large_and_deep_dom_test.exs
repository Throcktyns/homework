defmodule LargeAndDeepDOM do
  use Hound.Helpers
  use ExUnit.Case
  alias LargeDeep, as: LDeep
  hound_session()

  # https://github.com/SeleniumHQ/selenium/issues/10447, Seems to be a bug in chromedriver 99 preventing smooth running here. Bad inspector message.
  # Bad Inspector Message error ... “when Selenium can't parse the HTML or text of the elements because the elements are invalid unicode characters”.

  @moduletag timeout: 4500
  setup do
    navigate_to("https://the-internet.herokuapp.com/large", 1)
    :ok
  end

  # These tests would be a great candidate for data driven tests on my current framework. Only the row and column need adjusting to verify points on the table.
  test "first on table" do
    row = 1
    column = 1
    grid_return = visible_text(LDeep.row_and_column_ele(row, column))
    assertGrid(grid_return, row, column)
  end

  test "last on table" do
    row = 50
    column = 50
    grid_return = visible_text(LDeep.row_and_column_ele(row, column))
    assertGrid(grid_return, row, column)
  end

 test "random on table" do
    row = Enum.random(1..50)
    column = Enum.random(1..50)
    grid_return = visible_text(LDeep.row_and_column_ele(row, column))
    assertGrid(grid_return, row, column)
  end

  def assertGrid(grid_return, row, column) do
    assert(grid_return == "#{Integer.to_string(row)}.#{Integer.to_string(column)}", "--- EXPECTED: #{row}.#{column} GOT: #{grid_return} INSTEAD. ---")
  end
end
