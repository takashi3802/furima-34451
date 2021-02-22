require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品情報の保存' do

    context '商品が出品できる場合' do
      it 'image,name,description,caetgory_id,status_id,delivery_fee_id,delivery_area_id,delivery_day_id,priceがあれば出品できる' do
        expect(@item).to be_valid
      end

      it'priceは、¥300以上なら保存可能であること'do
        @item.price = '300'
        expect(@item).to be_valid
      end

      it'priceは、¥9,999,999以下なら保存可能であること'do
        @item.price = '9999999'
        expect(@item).to be_valid
      end

      it'priceは、半角英数のみ保存可能であること'do
        @item.price = '1111'
        expect(@item).to be_valid
      end

    end

    context '商品が出品できない場合' do

      it 'imageが空では登録できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'nameが空では登録できないこと' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it 'descriptionsが空では登録できないこと' do
        @item.descriptions = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Descriptions can't be blank")
      end

      it 'category_idが空では登録できないこと' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category is not a number")
      end

      it 'status_idが空では登録できないこと' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Status is not a number")
      end

      it 'delivery_fee_idが空では登録できないこと' do
        @item.delivery_fee_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery fee is not a number")
      end

      it 'delivery_area_idが空では登録できないこと' do
        @item.delivery_area_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery area is not a number")
      end

      it 'delivery_day_idが空では登録できないこと' do
        @item.delivery_day_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery day is not a number")
      end

      it 'priceが空では登録できないこと' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank", "Price  Half-width number", "Price Price Out of setting range")
      end

      it'priceは、¥300未満なら保存できないこと'do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Price Out of setting range")
      end

      it'priceは、¥10000000以上なら保存できないこと'do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Price Out of setting range")
      end

      it'priceは、半角英語では保存できないこと'do
        @item.price = 'aaaa'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Price Out of setting range")
      end

      it'priceは、全角数字では保存できないこと'do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Price Out of setting range")
      end

      it'priceは、全角英語では保存できないこと'do
        @item.price = 'ＡＡＡＡ'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Price Out of setting range")
      end


    end
  end
end

