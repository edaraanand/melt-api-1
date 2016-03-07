module Randomized
  extend ActiveSupport::Concern

  included do
    before_validation :randomize_id
  end

  def randomize_id
    begin
      self.id = SecureRandom.random_number(100_000_000)
    end while self.class.where(id: self.id).exists?
  end
end
