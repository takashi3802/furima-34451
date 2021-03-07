require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '新規登録できるとき' do
      it 'Eメール,パスワード,パスワード（確認）,nickname,last_name,first_name,last_name_kana,first_name_kana,birth_dayが存在すれば登録できる' do
        expect(@user).to be_valid
      end

      it 'パスワードが6文字以上であれば登録できること' do
        @user.password = '12345a'
        @user.password_confirmation = '12345a'
        expect(@user).to be_valid
      end

      it 'パスワードが半角英数混合であれば登録できること' do
        @user.password = '111aaa'
        @user.password_confirmation = '111aaa'
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'ニックネームが空では登録できないこと' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end

      it 'Eメールが空では登録できないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください')
      end

      it 'パスワードが空では登録できないこと' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end

      it 'お名前(姓)が空では登録できないこと' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(姓)を入力してください')
      end

      it 'お名前(名)が空では登録できないこと' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(名)を入力してください')
      end

      it 'お名前カナ(姓)が空では登録できないこと' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(姓)を入力してください')
      end

      it 'お名前カナ(名)が空では登録できないこと' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(名)を入力してください')
      end

      it '生年月日が空では登録できないこと' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('生年月日を入力してください')
      end

      it 'パスワードが5文字以下であれば登録できないこと' do
        @user.password = '1234a'
        @user.password_confirmation = '1234a'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'パスワードは半角数字のみでは登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字混合で入力してください')
      end

      it 'パスワードは半角英語のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字混合で入力してください')
      end

      it 'お名前(姓)は全角でなければ登録できない' do
        @user.last_name = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(姓)は全角で入力してください')
      end

      it 'お名前(名)は全角でなければ登録できない' do
        @user.first_name = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(名)は全角で入力してください')
      end

      it 'お名前カナ(姓)は全角でなければ登録できない' do
        @user.last_name_kana = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(姓)は全角カタカナで入力してください')
      end

      it 'お名前カナ(名)は全角でなければ登録できない' do
        @user.first_name_kana = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(名)は全角カタカナで入力してください')
      end

      it 'パスワードが存在してもパスワード（確認用）が空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end

      it 'パスワードとパスワード（確認用）が不一致では登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end

      it '重複したEメールが存在する場合登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it 'Eメールに@がないと登録できないこと' do
        @user.email = 'test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
    end
  end
end
