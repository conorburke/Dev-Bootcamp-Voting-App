class Idea < ApplicationRecord
  belongs_to :student
  has_many :votes
  has_many :choices

  validates :title, presence: true, uniqueness: true
  validates :student, presence: true
end
