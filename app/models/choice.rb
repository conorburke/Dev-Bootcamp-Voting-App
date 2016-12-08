class Choice < ApplicationRecord
  belongs_to :student
  belongs_to :idea

  validates :student, :preference_level, :idea, presence: true
  validates :preference_level, numericality: { greater_than_or_equal_to: 1 },
            uniqueness: { scope: :student_id, message: "cannot be the same" }
  validates :idea, uniqueness: { scope: :student_id, message: "should not be chosen more than once"}
end
