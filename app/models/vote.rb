class Vote < ApplicationRecord
  belongs_to :idea
  belongs_to :student

  validates :idea, :student, :round, presence: true
  validate :valid_vote

  def valid_vote
    current_votes_for_student = Vote.where("student_id = ? AND round = ?", self.student_id, self.round)
    unless current_votes_for_student.count < 3
      return errors.add :student, "can only vote 3 times each round"
    end

    ideas_voted_this_round = current_votes_for_student.map { |vote| vote.idea }
    if ideas_voted_this_round.include?(self.idea)
      errors.add :student, "cannot vote for same idea in same round"
    end
  end
end
