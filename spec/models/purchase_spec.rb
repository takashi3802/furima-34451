require 'rails_helper'

RSpec.describe Purchase, type: :model do
  describe '寄付情報の保存' do
    before do
      @purchase_address = FactoryBot.build(:purchase_address)
    end

    context '購入情報が保存できる場合' do

      it 'postal_code,delivery_area_id,municipalities,house_number,phoneが正しく入力されていれば保存できること' do
        expect(@purchase_address).to be_valid
      end

    end

    context '購入情報が保存できない場合' do

      it 'postal_codeが空だと保存できないこと' do
        @purchase_address.postal_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'delivery_area_idが空だと保存できないこと' do
        @purchase_address.delivery_area_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Delivery area Delivery area Select")
      end

      it 'municipalitiesが空だと保存できないこと' do
        @purchase_address.municipalities = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Municipalities can't be blank")
      end

      it 'house_numberが空だと保存できないこと' do
        @purchase_address.house_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("House number can't be blank")
      end

      it 'phoneが空だと保存できないこと' do
        @purchase_address.phone = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone can't be blank")
      end

      it 'postal_codeはハイフンがないと保存できないこと' do
        @purchase_address.postal_code = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code Postal code Input correctly")
      end

      it 'phoneは11桁以内でないと保存できないこと' do
        @purchase_address.phone = '123456789012'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone Phone number Input only number")
      end

    end
  end
end
  