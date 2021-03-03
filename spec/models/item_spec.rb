require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品情報の保存' do
    context '商品が出品できる場合' do
      it '画像,商品名,商品の説明,カテゴリー,商品の状態,配送料の負担,配送元の地域,発送までの日数,価格があれば出品できる' do
        expect(@item).to be_valid
      end

      it '価格は、¥300以上なら保存可能であること' do
        @item.price = '300'
        expect(@item).to be_valid
      end

      it '価格は、¥9,999,999以下なら保存可能であること' do
        @item.price = '9999999'
        expect(@item).to be_valid
      end

      it '価格は、半角英数のみ保存可能であること' do
        @item.price = '1111'
        expect(@item).to be_valid
      end
    end

    context '商品が出品できない場合' do
      it '画像が空では登録できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end

      it '商品名が空では登録できないこと' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end

      it '商品の説明が空では登録できないこと' do
        @item.descriptions = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end

      it 'カテゴリーが空では登録できないこと' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを選んでください')
      end

      it '商品の状態が空では登録できないこと' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を選んでください')
      end

      it '配送料の負担が空では登録できないこと' do
        @item.delivery_fee_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を選んでください')
      end

      it '配送元の地域が空では登録できないこと' do
        @item.delivery_area_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('配送元の地域を選んでください')
      end

      it '発送までの日数が空では登録できないこと' do
        @item.delivery_day_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を選んでください')
      end

      it '価格が空では登録できないこと' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください", '価格は半角数字で入力してください',
                                                      '価格は300〜9.999.999で入力してください')
      end

      it 'カテゴリーが -- では登録できないこと' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを選んでください')
      end

      it '商品の状態が -- では登録できないこと' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を選んでください')
      end

      it '配送料の負担が -- では登録できないこと' do
        @item.delivery_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を選んでください')
      end

      it '配送元の地域が -- では登録できないこと' do
        @item.delivery_area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配送元の地域を選んでください')
      end

      it '発送までの日数が -- では登録できないこと' do
        @item.delivery_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を選んでください')
      end

      it '価格は、¥300未満なら保存できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は300〜9.999.999で入力してください')
      end

      it '価格は、¥10000000以上なら保存できないこと' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は300〜9.999.999で入力してください')
      end

      it '価格は、半角英語では保存できないこと' do
        @item.price = 'aaaa'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は半角数字で入力してください')
      end

      it '価格は、全角数字では保存できないこと' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は半角数字で入力してください')
      end

      it '価格は、全角英語では保存できないこと' do
        @item.price = 'ＡＡＡＡ'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は半角数字で入力してください')
      end
    end
  end
end
