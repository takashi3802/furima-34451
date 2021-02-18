## usersテーブル

|Column              |Type     |Options       |
|--------------------|--------|--------------|
| nickname           | string | null: false  |
| email              | string | unique: true |
| encrypted_password | string | null: false  |
| first_name         | string | null: false  |
| last_name          | string | null: false  |
| first_name_kana    | string | null: false  |
| last_name_kana     | string | null: false  |
| birth_day          | date   | null: false  |


### Association
has_many :items
has_many :purchases


## itemsテーブル

|Column            |Type       |Options                        |
|------------------|-----------|-------------------------------|
| name             | string    | null: false                   |
| descriptions     | text      | null: false                   |
| category         | string    | null: false                   |
| status           | string    | null: false                   |
| delivery_fee_id  | integer   | null: false                   |
| delivery_area_id | integer   | null: false                   |
| delivery_day_id  | integer   | null: false                   |
| price            | integer   | null: false                   |
| user             | reference | null: false, foreign_key: true|

### Association
belongs_to :user
has_one :purchase


## purchasesテーブル

|Column |Type       |Options                        |
|-------|-----------|-------------------------------|
| item  | reference | null: false, foreign_key: true|
| user  | reference | null: false, foreign_key: true|

### Association
belongs_to :user
belongs_to :item
has_one    :address


## addressesテーブル

|Column             |Type    |Options      |
|-------------------|--------|-------------|
| postal_code       | string | null: false |
| delivery_ area_id | string | null: false |
| municipalities    | string | null: false |
| house_number      | string | null: false |
| building          | string |             |
| phone             | string | null: false |

### Association
belongs_to :purchase