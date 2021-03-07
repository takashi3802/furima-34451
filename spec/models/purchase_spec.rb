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
      it '郵便番号,都道府県,市区町村,番地,電話番号,価格,クレジットカード情報が正しく入力されていれば保存できること' do
        expect(@purchase_address).to be_valid
      end

      it '建物名が空でも保存できること' do
        @purchase_address.building = ''
        expect(@purchase_address).to be_valid
      end
    end

    context '購入情報が保存できない場合' do
      it '郵便番号が空だと保存できないこと' do
        @purchase_address.postal_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Postal codeを入力してください')
      end

      it '都道府県が空だと保存できないこと' do
        @purchase_address.delivery_area_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Delivery areaを入力してください', 'Delivery areaを選んでください')
      end

      it '市区町村が空だと保存できないこと' do
        @purchase_address.municipalities = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Municipalitiesを入力してください')
      end

      it '番地が空だと保存できないこと' do
        @purchase_address.house_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('House numberを入力してください')
      end

      it '電話番号が空だと保存できないこと' do
        @purchase_address.phone = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phoneを入力してください')
      end

      it 'クレジットカード情報が空だと保存できないこと' do
        @purchase_address.token = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Tokenを入力してください')
      end

      it '郵便番号はハイフンがないと保存できないこと' do
        @purchase_address.postal_code = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Postal codeは-を入力してください')
      end

      it '電話番号は11桁以内でないと保存できないこと' do
        @purchase_address.phone = '123456789012'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phoneは11桁以内の半角数字で入力してください')
      end

      it '都道府県が -- では登録できないこと' do
        @purchase_address.delivery_area_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Delivery areaを選んでください')
      end

      it 'user_idが空だと登録できない' do
        @purchase_address.user_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Userを入力してください')
      end

      it 'item_idが空だと登録できない' do
        @purchase_address.item_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Itemを入力してください')
      end
    end
  end
end
