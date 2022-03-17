defmodule LargeDeep do
  use Hound.Helpers

  # This is a 50 X 50 grid. Pass in the row and column to pull the specified element.
  def row_and_column_ele(row, column) do
    find_element(:xpath, "//h4[text()='Siblings']") |> click()
    send_keys(:pagedown)
    find_element(:xpath, "//h4[text()='Table']")
    send_keys(:pagedown)
    find_element(:css, "tr.row-#{row} td.column-#{column}")
  end
end
