class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :delivery_area_id, :municipalities, :house_number, :building, :phone, :item_id, :user_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'は-を入力してください' }
    validates :phone, format: { with: /\A[0-9]{11}\z/, message: 'は11桁以内の半角数字で入力してください' }
    validates :municipalities, :house_number, :user_id, :item_id, :token
    validates :delivery_area_id, numericality: { other_than: 1 ,message: 'を選んでください' }
  end

  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    Address.create(postal_code: postal_code, delivery_area_id: delivery_area_id, municipalities: municipalities,
                   house_number: house_number, building: building, phone: phone, purchase_id: purchase.id)
  end
end
