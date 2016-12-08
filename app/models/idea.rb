class Idea < ApplicationRecord
  belongs_to :student
  has_one :cohort, through: :student
  has_one :group
  has_many :votes
  has_many :choices
  has_many :rounds, through: :votes

  validates :title, presence: true
  validate :unique_in_cohort

  def unique_in_cohort
    unless self.student
      return errors.add :student, "must exists"
    end

    cohort_idea_names = self.student.cohort.ideas.map { |idea| idea.title }
    if cohort_idea_names.include? self.title
      errors.add :title, "has already been taken"
    end
  end

  def active?
    self.active == 1
  end
end
