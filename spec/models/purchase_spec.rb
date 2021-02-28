require 'rails_helper'

RSpec.describe Purchase, type: :model do
  describe '購入情報の保存' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @purchase_address = FactoryBot.build(:purchase_address, user_id: @user.id, item_id: @item.id)
      sleep(1)
    end

    context '購入情報が保存できる場合' do
      it 'postal_code,delivery_area_id,municipalities,house_number,phone,price,tokenが正しく入力されていれば保存できること' do
        expect(@purchase_address).to be_valid
      end

      it 'buildingが空でも保存できること' do
        @purchase_address.building = ''
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
        expect(@purchase_address.errors.full_messages).to include('Delivery area is not a number')
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

      it 'tokenが空だと保存できないこと' do
        @purchase_address.token = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'postal_codeはハイフンがないと保存できないこと' do
        @purchase_address.postal_code = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Postal code Postal code Input correctly')
      end

      it 'phoneは11桁以内でないと保存できないこと' do
        @purchase_address.phone = '123456789012'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone Phone number Input only number')
      end

      it 'delivery_area_idが -- では登録できないこと' do
        @purchase_address.delivery_area_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Delivery area must be other than 1')
      end

      it 'user_idが空だと登録できない' do
        @purchase_address.user_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空だと登録できない' do
        @purchase_address.item_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
