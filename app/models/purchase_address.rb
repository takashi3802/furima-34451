class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :delivery_area_id, :municipalities, :house_number, :building, :phone, :user_id, :item_id

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "Postal code Input correctly"}
    validates :phone, format:{with: /\A[0-9]\z/, message: "Phone number Input only number"}
    validates :municipalities, :house_number, :user_id, :item_id
  end
  validates :delivery_area_id, numericality: {other_than: 0, message: "Delivery_area Select"}

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, delivery_area_id: delivery_area.id, city: city, municipalities: municipalities, house_number: house_number, building: building, phone: phone)
  end
end