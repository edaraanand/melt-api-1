module Features
  def sign_in(email, password)
    visit root_path

    click_on("Sign in")
    fill_in("Email", with: email)
    fill_in("user_password", with: password)
    click_button("Sign in")
  end
end
