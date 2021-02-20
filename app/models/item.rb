class Item < ApplicationRecord
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :descriptions
    validates :price
    validates :user
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :delivery_area
  belongs_to :delivery_day

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :status_id
    validates :delivery_fee_id
    validates :delivery_area_id
    validates :delivery_day_id
  end
end

