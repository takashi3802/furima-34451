class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :card, dependent: :destroy

  has_many :items, dependent: :destroy
  has_many :purchases, dependent: :destroy

  with_options presence: true do
    validates :nickname
    validates :birth_day
  end

  with_options presence: true, format: { with: /\A[ァ-ヶ]+\z/, message: 'は全角カタカナで入力してください' } do
    validates :first_name_kana
    validates :last_name_kana
  end

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: 'は全角で入力してください' } do
    validates :first_name
    validates :last_name
  end

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'は半角英数字混合で入力してください'
end
