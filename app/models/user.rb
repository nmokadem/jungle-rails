class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true , uniqueness: { case_sensitive: false }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, confirmation: { case_sensitive: true }
  validates :password_confirmation, presence: true
  validates :password, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)

    if user && user.authenticate(password)
      user
    else
      nil
    end

  end

  private
  def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation )
  end

end
