class Student < ApplicationRecord
  belongs_to :group, optional: true
  belongs_to :cohort
  has_many :choices
  has_many :votes
  has_many :ideas # ideas pitched

  validates :first_name, :last_name, :email, :cohort, presence: true
  validates :access_code, :email, uniqueness: true

  before_validation :generate_access_code, on: :create

  def generate_access_code
    if !self.access_code && self.first_name && self.last_name && !self.last_name.empty?
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

  # -- Algorithm --------------------------------------

  def assigned?
    !!(self.group)
  end

  def votes_this_round
    self.votes.select { |vote| vote.round_id == self.current_access[-1].to_i}
  end

  def assign
    sample_pool = self.cohort.ideas.select { |idea| idea.active? }
    top_choice = self.choices.find { |choice| choice.preference_level == 1 } || sample_pool.sample
    top_choice = top_choice.idea unless top_choice.is_a? Idea
    top_group = self.cohort.groups.find { |group| group.idea == top_choice } || Group.find(1)
    self.update_attributes(group_id: top_group.id)
  end
end
