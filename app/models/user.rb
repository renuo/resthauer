class User < ApplicationRecord
  has_many :ratings
  has_many :menus, through: :ratings
end
