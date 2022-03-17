defmodule FormAuthentication do
  use Hound.Helpers
  use ExUnit.Case
  alias FormAuth, as: FAuth
  hound_session()

  setup do
    navigate_to "https://the-internet.herokuapp.com/login"
    :ok
  end

  test "successful login" do
    FAuth.setup_login()
    assert(element_displayed?(FAuth.success_flash_ele()), "User was not successfully logged in.")
  end

  test "invalid login" do
    FAuth.setup_login("Banana", "Splits")
    assert(element_displayed?(FAuth.failure_flash_ele()), "Invalid username banner was not displayed.")
  end

  test "logout" do
    FAuth.setup_login()
    click(FAuth.logout_ele())
    assert(element_displayed?(FAuth.success_flash_ele()), "User was not taken back to the login screen.")
  end
end
