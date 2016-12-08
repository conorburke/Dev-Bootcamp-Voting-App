class Cohort < ApplicationRecord
  belongs_to :city
  has_many :students
  has_many :rounds
  has_many :teachers, through: :city
  has_many :ideas, through: :students
  has_many :groups, through: :ideas, source: :group

  validates :name, :city, presence: true
end
