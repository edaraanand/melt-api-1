class Account < ActiveRecord::Base
  include Randomized

  before_validation :generate_test_api_key

  has_many :users
  has_many :addresses, dependent: :destroy

  private

  def generate_test_api_key
    self.test_api_key = "test_#{SecureRandom.base64.tr('+/=', 'nopqrstuvwkyzabcdefghijklm')}"
  end
end
