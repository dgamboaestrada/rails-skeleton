class User < ApplicationRecord
  has_secure_password

  before_save   :downcase_email

  validates :email, :password_digest, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  private

  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end

end
