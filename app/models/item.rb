class Item < ApplicationRecord
  has_one_attached :image

  has_one :purchase
  belongs_to :user

  validates :price, presence: true, format: { with: /\A[0-9]\d+\z/, message: 'は半角数字で入力してください' },
                    numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'は300〜9.999.999で入力してください' }

  with_options presence: true do
    validates :name
    validates :descriptions
    validates :image
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :delivery_area
  belongs_to :delivery_day

  with_options numericality: { other_than: 1, message: 'を選んでください' } do
    validates :category_id
    validates :status_id
    validates :delivery_fee_id
    validates :delivery_area_id
    validates :delivery_day_id
  end
end
