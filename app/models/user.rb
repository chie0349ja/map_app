class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:line]
  has_many :spots
  has_many :sns_credentials

  def self.from_omniauth(auth)
    # SnsCredentialから既存の認証情報を取得
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_initialize
  
    # すでにSNS認証情報が保存されている場合は、その関連するユーザーを取得
    if sns.persisted?
      user = sns.user
    else
      # 新規のSNS認証の場合、メールアドレスでユーザーを検索または初期化
      user = User.where(email:"line_email@#{auth.uid}.com").first_or_initialize(
        nickname: auth.info.name,
        email: "line_email@#{auth.uid}.com"
      )
  
      # 新規ユーザーの場合、ランダムなパスワードを設定して保存
      if user.new_record?
        user.password = Devise.friendly_token[0,20]
        user.save!
        sns.user = user
        sns.save!
      end
    end
  
    { user: user, sns: sns }
  end
end
