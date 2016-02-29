require 'rails_helper'

feature "User visits homepage" do
  scenario "successfully" do
    visit root_path
    expect(page).to have_content("Melt API. All Rights Reserved.")
  end

  scenario "and signs in successfully with valid credentials" do
    user = create(:user)
    sign_in(user.email, user.password)

    expect(page).to have_content("Dashboard")
  end

  scenario "and cannot sign in if not registered" do
    sign_in("noaccount@email.com", "password")

    expect(page).not_to have_content("Dashboard")
    expect(page).to have_content("Invalid email or password")
  end

  scenario "and cannot sign in with invalid email" do
    user = create(:user)
    sign_in("invalid@example.com", user.password)

    expect(page).not_to have_content("Dashboard")
    expect(page).to have_content("Invalid email or password")
  end

  scenario "and cannot sign in with invalid password" do
    user = create(:user)
    sign_in(user.email, "invalid")

    expect(page).not_to have_content("Dashboard")
    expect(page).to have_content("Invalid email or password")
  end
end
