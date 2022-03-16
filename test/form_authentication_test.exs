defmodule FormAuthentication do
  use Hound.Helpers
  use ExUnit.Case
  hound_session()

  @login_url "https://the-internet.herokuapp.com/login"
  @username "tomsmith"
  @password "SuperSecretPassword!"

  setup do
    navigate_to @login_url
    :ok
  end

  test "successful login" do
    setup_login()
    assert(element_displayed?(success_flash_ele()), "User was not successfully logged in.")
  end

  test "invalid login" do
    setup_login("Banana", "Splits")
    assert(element_displayed?(failure_flash_ele()), "Invalid username banner was not displayed.")
  end

  test "logout" do
    setup_login()
    click(logout_ele())
    assert(element_displayed?(success_flash_ele()), "User was not taken back to the login screen.")
  end

  # VVV Again, these don't belong here VVV.
  defp setup_login(username \\ @username, password \\ @password) do
    click_and_send(username_ele(), username)
    click_and_send(password_ele(), password)
    click(login_ele())
  end

  def click_and_send(element, text) do
    click(element)
    send_text(text)
  end

  def logout_ele do
    find_element(:css, "a[class*='button secondary']")
  end

  def failure_flash_ele do
    find_element(:css, "div[class='flash error']")
  end

  def success_flash_ele do
    find_element(:css, "div[class='flash success']")
  end

  def username_ele do
    find_element(:css, "input#username")
  end

  def password_ele do
    find_element(:css, "input#password")
  end

  def login_ele do
    find_element(:css, "button[type='submit']")
  end
end
