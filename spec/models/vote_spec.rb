require 'rails_helper'

RSpec.describe Vote, type: :model do
  let(:city) { City.create(name: "San Diego") }
  let(:cohort) { Cohort.create(name: "chipmunks", city_id: city.id) }
  let(:student) { Student.create(first_name: "Conor", last_name: "Burke", email: "conor@gmail.com", cohort_id: cohort.id) }
  let(:idea) { Idea.create(title: "idea", student_id: student.id) }
  let(:round) { Round.create(voting_round: 1, cohort_id: cohort.id) }
  let(:vote) { Vote.create(student_id: student.id, idea_id: idea.id, round_id: round.id) }

  describe "attributes" do
    it 'has a title' do
      expect(idea.title).to eq "idea"
    end
  end

  describe "associations" do
    it 'belongs to a student' do
      expect(vote.student).to eq student
    end

    it 'belongs to an idea' do
      expect(vote.idea).to eq idea
    end

    it 'belongs to a round' do
      expect(vote.round).to eq round
    end
  end

  describe "validations" do
    it 'student can only vote 3 times per round' do
      idea2 = Idea.create(title: "idea2", student_id: student.id)
      idea3 = Idea.create(title: "idea3", student_id: student.id)
      idea4 = Idea.create(title: "idea4", student_id: student.id)
      vote1 = Vote.create(student_id: student.id, idea_id: idea.id, round_id: round.id)
      vote2 = Vote.create(student_id: student.id, idea_id: idea2.id, round_id: round.id)
      vote3 = Vote.create(student_id: student.id, idea_id: idea3.id, round_id: round.id)
      invalid_vote = Vote.create(student_id: student.id, idea_id: idea4.id, round_id: round.id)
      expect(invalid_vote.errors[:student]).to include "can only vote 3 times each round"
    end

    it 'student cannot vote for same idea in same round' do
      vote = Vote.create(student_id: student.id, idea_id: idea.id, round_id: round.id)
      invalid_vote = Vote.create(student_id: student.id, idea_id: idea.id, round_id: round.id)
      expect(invalid_vote.errors[:student]).to include "cannot vote for same idea in same round"
    end
  end


end
