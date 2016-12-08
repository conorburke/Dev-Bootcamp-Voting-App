class Idea < ApplicationRecord
  belongs_to :student
  has_one :group
  has_many :votes
  has_many :choices
  has_many :rounds, through: :votes

  validates :title, presence: true, uniqueness: true
  validates :student, presence: true
end
