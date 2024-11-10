class Classroom < ApplicationRecord
  belongs_to :user  
  has_many :classroom_users, dependent: :destroy
  has_many :students, through: :classroom_users, source: :user
  has_many :posts, dependent: :destroy
end