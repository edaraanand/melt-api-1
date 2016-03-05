class User < ActiveRecord::Base
  before_create :randomize_id, :create_account

  belongs_to :account

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private

  def randomize_id
    begin
      self.id = SecureRandom.random_number(100_000_000)
    end while self.class.where(id: self.id).exists?
  end

  def create_account
    self.account = Account.new
    self.account_id = self.account.id
    self.account.save!
  end
end
