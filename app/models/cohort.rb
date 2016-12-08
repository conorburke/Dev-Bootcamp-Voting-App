class Cohort < ApplicationRecord
  belongs_to :city
  has_many :students
  has_many :rounds
  has_many :teachers, through: :city
  has_many :ideas, through: :students
  has_many :groups, through: :ideas, source: :group

  PHASES = ["ideas", "voting", "preference", "finished"]

  validates :name, :city, presence: true
  validates :name, uniqueness: { scope: :city_id }

  def next_phase
    index = self.class::PHASES.index(self.current_phase)
    if index < 3
      update_attribute(:current_phase, self.class::PHASES[index + 1])
      self.rounds.create if self.current_phase == "voting"
    end
  end

  def current_round
    if self.current_phase != "voting"
      0
    else
      self.rounds.count
    end
  end
end
