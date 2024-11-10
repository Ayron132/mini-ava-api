# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable,
          #:confirmable,
          :registerable,
          :recoverable,  
          :rememberable, 
          :trackable,
          :validatable
  include DeviseTokenAuth::Concerns::User
  # Definindo enum para o papel do usuário
  enum role: { teacher: 'teacher', student: 'student' }

  # Validação de presença e inclusão de role
  has_many :classrooms, dependent: :destroy
  has_many :posts, dependent: :destroy
  validates :role, presence: true, inclusion: { in: roles.keys }
  
end
