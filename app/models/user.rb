class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :generate_api_key

  def generate_api_key
    self.api_key = "test_#{SecureRandom.base64.tr('+/=', 'nopqrstuvwkyz')}#{SecureRandom.base64.tr('+/=', 'abcdefghijklm')}"
  end

end
