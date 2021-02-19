FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.name}
    email                 {Faker::Internet.free_email}
    password              {"000aaa"}
    password_confirmation {password}
    last_name             {"姓"}
    first_name            {"名"}
    last_name_kana        {"セイ"}
    first_name_kana       {"メイ"}
    birth_day             {"2000-01-01"}
  end
end