class Student < ApplicationRecord
  has_many :choices
  has_many :votes
  has_many :ideas # ideas pitched

  validates :first_name, :last_name, :email, :access_code, presence: true

  before_validation :generate_access_code, on: :create

  def generate_access_code
    self.access_code = "1234"
  end

  def full_name
    self.first_name + " " + self.last_name
  end

  def authenticate(password)
    self if self.access_code == password
  end
end
