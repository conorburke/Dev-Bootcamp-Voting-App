class Group < ApplicationRecord
  has_many :students
  belongs_to :idea
  has_one :cohort, through: :idea

  validates :name, presence: true
  validates :idea, presence: true, uniqueness: true

  before_validation :generate_name, on: :create

  def generate_name
    unless self.name
      self.name = "group #{self.cohort.groups.count + 1}" if self.cohort
    end
  end

  # if the group is filled
  def filled?(limit)
    self.students.count == limit
  end
end
