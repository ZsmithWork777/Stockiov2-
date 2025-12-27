class User < ApplicationRecord
  has_secure_password

  has_many :items, dependent: :destroy

  before_validation :normalize_email
  before_create :generate_api_token

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :api_token, uniqueness: true, allow_nil: true

  private

  def normalize_email
    self.email = email.to_s.downcase.strip
  end

  def generate_api_token
    self.api_token = SecureRandom.hex(32)
  end
end
