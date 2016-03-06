class Address < ActiveRecord::Base
  before_validation :randomize_id

  belongs_to :account

  validates :description, :name, :address_line_1, :address_city,
            :address_state, :address_zip, :address_country, presence: true

  private

  def randomize_id
    begin
      self.id = SecureRandom.random_number(100_000_000)
    end while self.class.where(id: self.id).exists?
  end

end
