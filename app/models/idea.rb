class Idea < ApplicationRecord
  belongs_to :student
  has_many :votes
  has_many :choices
  has_many :groups
  has_many :rounds, through: :votes

  validates :title, presence: true, uniqueness: true
  validates :student, presence: true
end
