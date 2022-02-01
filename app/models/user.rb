class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  before_save :downcase_email
  before_destroy :check_admin_number, prepend: true

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }

  private

  def downcase_email
    self.email = email.downcase
  end

  def check_admin_number
    @user = User.find(id)

    throw :abort if User.where(admin: true).count == 1 && @user.admin?
  end
end
