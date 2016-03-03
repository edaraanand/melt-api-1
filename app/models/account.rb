class Account < ActiveRecord::Base
  before_create :randomize_id, :generate_test_api_key
  before_validation :generate_test_api_key

  has_many :users
  has_many :addresses, dependent: :destroy

  private

  def randomize_id
    begin
      self.id = SecureRandom.random_number(100_000)
    end while self.class.where(id: self.id).exists?
  end

  def generate_test_api_key
    self.test_api_key = "test_#{SecureRandom.base64.tr('+/=', 'nopqrstuvwkyzabcdefghijklm')}"
  end
end
