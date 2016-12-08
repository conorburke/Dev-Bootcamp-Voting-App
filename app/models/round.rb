class Round < ApplicationRecord
  belongs_to :cohort
  has_many :votes
  has_many :ideas, through: :votes

  validates :voting_round, presence: true, numericality: {greater_than: 0}
  validates :cohort_id, presence: true

  before_validation :generate_round, on: :create

  def generate_round
    self.voting_round = self.cohort.rounds.count + 1 if self.cohort
  end
end
