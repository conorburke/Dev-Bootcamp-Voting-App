class Teacher < ApplicationRecord
  belongs_to :city
  has_many :cohorts, through: :city
  has_many :students, through: :cohorts

  validates :first_name, :last_name, :email, :access_code, :city, presence: true
  validates :access_code, :email, uniqueness: true

  before_validation :generate_access_code, on: :create

  def generate_access_code
    if !self.access_code && self.first_name && self.last_name
      self.access_code = (self.first_name + self.last_name[0]).downcase
    end
  end

  def authenticate(password)
    self if self.access_code == password
  end

  # -- Display ----------------------------------------

  def full_name
    self.first_name.capitalize + " " + self.last_name.capitalize
  end
end
