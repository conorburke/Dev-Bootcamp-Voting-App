class Choice < ApplicationRecord
  belongs_to :student
  belongs_to :idea

  validates :student, :idea, presence: true
  validates :preference_level, numericality: { greater_than_or_equal_to: 1 },
            uniqueness: { scope: :student_id, message: "cannot be the same" }
  validates :idea, uniqueness: { scope: :student_id, message: "should not be chosen more than once"}
  validate :valid_preference_level

  # preference_level cannot exceeds total number of active ideas
  def valid_preference_level
    unless self.preference_level
      return errors.add :preference_level, "can't be blank"
    end

    unless self.student
      return errors.add :student, "can't be blank"
    end

    active_ideas = self.student.ideas.to_a.select { |idea| idea.active? }
    unless self.preference_level <= active_ideas.length
      errors.add :preference_level, "cannot exceed total number of options"
    end
  end
end
