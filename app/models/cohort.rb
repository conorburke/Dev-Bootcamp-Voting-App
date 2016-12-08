class Cohort < ApplicationRecord
  belongs_to :city
  has_many :students
  has_many :rounds
  has_many :teachers, through: :city

  validates :name, presence: true
end
