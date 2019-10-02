class User < ApplicationRecord
  validates :name, presence: true  # same as: validates(:name, {presence: true})
  validates :email, presence: true
end
