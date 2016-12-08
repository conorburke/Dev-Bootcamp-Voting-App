class City < ApplicationRecord
  has_many :teachers
  has_many :cohorts
  has_many :students, through: :cohorts

  validates :name, presence: true, uniqueness: true
end
