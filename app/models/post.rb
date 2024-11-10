class Post < ApplicationRecord
  belongs_to :classroom
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :responses, dependent: :destroy
  has_many :fields, dependent: :destroy
  accepts_nested_attributes_for :fields

  validates :title, :description, :post_type, presence: true
  enum post_type: { comunicado: 'comunicado', atividade: 'atividade' }
end