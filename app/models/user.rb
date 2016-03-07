class User < ActiveRecord::Base
  include Randomized

  before_create :create_account

  belongs_to :account

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private

  def create_account
    self.account = Account.new
    self.account_id = self.account.id
    self.account.save!
  end
end
