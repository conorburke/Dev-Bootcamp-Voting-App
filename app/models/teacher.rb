class Teacher < ApplicationRecord
  belongs_to :city
  has_one :cohort, through: :city
  has_many :students, through: :cohort

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
end
