class Vote < ApplicationRecord
  belongs_to :idea
  belongs_to :student

  validates :idea, :student, presence: true
end
