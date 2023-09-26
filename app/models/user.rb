class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:line]
  has_many :spots
  has_many :sns_credentials

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = User.where(email:"line_email@#{auth.uid}.com").first_or_initialize(
      nickname: auth.info.name,
      email: "line_email@#{auth.uid}.com"
    )

    if user.new_record?
      user.password = Devise.friendly_token[0,20]
      sns.user = user
      sns.save!
    end

    { user: user, sns: sns }
  end
end
