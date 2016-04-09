require 'rails_helper'

feature 'Address Book' do
  describe 'user views addresses' do
    scenario 'without any addresses' do
      create_and_sign_in_user
      click_link 'Address Book'

      expect(page).to have_content 'You have no Addresses added.'
    end

    scenario 'with an address' do
      create_and_sign_in_user
      create(:address, account_id: User.last.account_id).save

      click_link 'Address Book'

      expect(page).not_to have_content 'You have no Addresses added.'
    end
  end

  describe 'user creates an address' do
    scenario 'without choosing an environment' do
      create_and_sign_in_user
      click_link 'Address Book'
      click_link 'Create new address'

      expect(page).to have_content 'Create a New Address'

      create_an_address

      expect(page).to have_content 'Address Created'

      click_link 'Address Book'

      expect(page).to have_content 'Sally - Home'
      expect(page).not_to have_content 'You have no Addressess added.'
    end

    scenario 'with LIVE environment specified' do
      create_and_sign_in_user
      click_link 'Address Book'
      click_link 'Create new address'

      expect(page).to have_content 'Create a New Address'

      create_an_address

      expect(page).to have_content 'Address Created'

      click_link 'Address Book'

      expect(page).to have_content 'Sally - Home'
      expect(page).not_to have_content 'You have no Addressess added.'
    end
  end

  def create_and_sign_in_user
    user = create(:user)
    user.save
    sign_in(user.email, user.password)
  end

  def create_an_address
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
  end
end
