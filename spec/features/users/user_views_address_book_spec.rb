require 'rails_helper'

feature 'User views address book' do
  scenario 'without any addresses' do
    user = create(:user)
    sign_in(user.email, user.password)

    click_link "Address Book"

    expect(page).to have_content "You have no Addresses added."
  end
end
