require 'rails_helper'

feature 'Address Book' do
  scenario 'user views without any addresses' do
    user = create(:user)
    user.save
    sign_in(user.email, user.password)

    click_link 'Address Book'

    expect(page).to have_content 'You have no Addresses added.'
  end

  scenario 'user creates an address' do
    user = create(:user)
    user.save
    sign_in(user.email, user.password)

    click_link 'Address Book'
    click_link 'Create new address'

    expect(page).to have_content 'Create a New Address'

    fill_in('address[description]',     with: 'Sally - Home')
    fill_in('address[name]',            with: 'Sally Johnson')
    fill_in('address[company]',         with: 'Company Inc.')
    fill_in('address[address_line_1]',  with: '123 Test Road')
    fill_in('address[address_line_2]',  with: 'Suite 1')
    fill_in('address[address_city]',    with: 'San Francisco')
    fill_in('address[address_state]',   with: 'California')
    fill_in('address[address_zip]',     with: '94110')
    select('United States',             from: 'address[address_country]')
    fill_in('address[phone]',           with: '222-222-222')
    fill_in('address[email]',           with: 'sally@melthq.com')
    click_on('create')

    expect(page).to have_content 'Address Created'

    click_link 'Address Book'

    expect(page).to have_content 'Sally - Home'
    expect(page).not_to have_content 'You have no Addressess added.'
  end
end
