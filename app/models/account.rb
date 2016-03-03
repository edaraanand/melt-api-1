class Account < ActiveRecord::Base
  before_create :randomize_id

  belongs_to :user

  validates :user_id, presence: true

  private

  def randomize_id
    begin
      self.id = SecureRandom.random_number(100_000)
    end while self.class.where(id: self.id).exists?
  end
end
