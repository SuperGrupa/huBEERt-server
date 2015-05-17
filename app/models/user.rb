class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :auth_tokens

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  # Ensure deleted users cannot sign in
  # def active_for_authentication?
  #   super && !deleted_at
  # end

  # Used for user authentication
  def ensure_authentication_token (remember)
    token = AuthToken.create!(token: generate_authentication_token,
                               remember: remember,
                               user_id: self.id)
  end

  private
    def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token unless AuthToken.where(token: token).first
      end
    end
end
