defmodule FormAuth do
  use Hound.Helpers
  @username "tomsmith"
  @password "SuperSecretPassword!"

  def setup_login(username \\ @username, password \\ @password) do
    click_and_send(username_ele(), username)
    click_and_send(password_ele(), password)
    click(login_ele())
  end

  defp click_and_send(element, text) do
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
