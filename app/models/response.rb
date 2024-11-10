class Response < ApplicationRecord
  belongs_to :user
  belongs_to :post

  store :data, coder: JSON
  validates_uniqueness_of :user_id, scope: :post_id, message: "só pode responder uma vez"
end