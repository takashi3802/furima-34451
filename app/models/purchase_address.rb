class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :delivery_area_id, :municipalities, :house_number, :building, :phone, :item_id, :user_id, :price,
                :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'Postal code Input correctly' }
    validates :phone, format: { with: /\A[0-9]{11}\z/, message: 'Phone number Input only number' }
    validates :municipalities, :house_number, :user_id, :item_id, :price, :token
    validates :delivery_area_id, numericality: { other_than: 1 }
  end

  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    Address.create(postal_code: postal_code, delivery_area_id: delivery_area_id, municipalities: municipalities,
                   house_number: house_number, building: building, phone: phone, purchase_id: purchase.id)
  end
end
