module Randomized
  extend ActiveSupport::Concern

  included do
    before_validation :randomize_uuid, :randomize_id
  end

  def randomize_uuid
    case self.class.to_s
    when "Address"
      generate_uuid('adr')
    when "Account"
      generate_uuid('acc')
    when "User"
      generate_uuid('usr')
    end
  end

  def randomize_id
    begin
      self.id = SecureRandom.random_number(100_000_000)
    end while self.class.where(id: self.id).exists?
  end

  private

  def generate_uuid(prefix)
    begin
      self.uuid =
        "#{prefix}_#{SecureRandom.urlsafe_base64.tr('+/=_-', 'nopqrstuvwkyzabcdefghijklm')}"
    end while self.class.where(id: self.uuid).exists?
  end
end
