class Teacher < ApplicationRecord
  belongs_to :city
  has_many :cohorts, through: :city
  has_many :students, through: :cohorts

  validates :first_name, :last_name, :access_code, presence: true
  validates :email, presence: true, uniqueness: true
end
