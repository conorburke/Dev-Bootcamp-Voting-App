class Idea < ApplicationRecord
  belongs_to :student
  has_many :votes, :choices
  validates :title, presence: true, uniqueness: true
end
