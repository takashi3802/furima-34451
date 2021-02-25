class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :user
  has_one :address
end
