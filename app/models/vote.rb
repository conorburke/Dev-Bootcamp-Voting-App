class Vote < ApplicationRecord
  belongs_to: :idea, :student
end
