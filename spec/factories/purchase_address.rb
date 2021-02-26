FactoryBot.define do
  factory :purchase_address do
    postal_code { "123-4567" }
    delivery_area_id { 2 }
    municipalities { '福岡' }
    house_number { '1-1' }
    building { '福岡ハイツ' }
    phone { "00000000000" }
    user_id {1}
    item_id{1}
  end
end