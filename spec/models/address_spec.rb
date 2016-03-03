require 'rails_helper'

describe Address do
  context 'associations' do
    it { should belong_to(:account) }
  end

  context 'validations' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address_line_1) }
    it { should validate_presence_of(:address_city) }
    it { should validate_presence_of(:address_state) }
    it { should validate_presence_of(:address_zip) }
    it { should validate_presence_of(:address_country) }
  end
end
