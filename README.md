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

|Column          |Type       |Options                        |
|----------------|-----------|-------------------------------|
| name           | string    | null: false                   |
| descriptions   | text      | null: false                   |
| category       | string    | null: false                   |
| status         | string    | null: false                   |
| delivery_fee   | string    | null: false                   |
| delivery_ area | string    | null: false                   |
| delivery_days  | string    | null: false                   |
| price          | integer   | null: false                   |
| fee            | integer   | null: false                   |
| profit         | integer   | null: false                   |
| user_id        | reference | null: false, foreign_key: true|

### Association
belongs_to :user
has_one :purchase


## purchaseテーブル

|Column            |Type       |Options                        |
|------------------|-----------|-------------------------------|
| credit_number    | integer   | null: false                   |
| expiration_month | integer   | null: false                   |
| expiration_year  | integer   | null: false                   |
| security_code    | integer   | null: false                   |
| user_id          | reference | null: false, foreign_key: true|

### Association
belongs_to :user
has_one    :item
has_one    :address


## addressesテーブル

|Column          |Type     |Options      |
|----------------|---------|-------------|
| postal_code    | integer | null: false |
| prefectures    | string  | null: false |
| municipalities | string  | null: false |
| house_number   | string  | null: false |
| building       | string  |             |
| phone          | integer | null: false |

### Association
has_one :purchases