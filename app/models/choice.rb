class Choice < ApplicationRecord
  belongs_to :student
  belongs_to :idea

  validates :student, :idea, :preference_level, presence: true
  validates :preference_level, numericality: { greater_than_or_equal_to: 1 }
end
