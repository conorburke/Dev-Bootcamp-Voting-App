require 'rails_helper'

RSpec.describe Vote, type: :model do
  let(:city) { City.create(name: "San Diego") }
  let(:cohort) { Cohort.create(name: "chipmunks-2016", city_id: city.id) }
  let(:student) { Student.create(first_name: "Conor", last_name: "Burke", email: "conor@gmail.com", access_code: "1234", cohort_id: 1, group_id: 1) }
  let(:idea) { Idea.create(title: "idea", student_id: student.id) }
  let(:choice) {Choice.create(student_id: student.id, idea_id: idea.id, preference_level: 3)}
  let(:round) {Round.create(voting_round: 1, cohort_id: 1)}
  let(:vote) {Vote.create(student_id: student.id, idea_id: idea.id, round_id: 1)}
  describe "attributes" do

    it 'has a student_id' do
      expect(vote.student_id).to eq student.id
    end

    it 'has a idea_id' do
      expect(vote.idea_id).to eq idea.id
    end

    it 'has a round id' do
      expect(vote.round_id).to eq 1
    end
  end

  describe "associations" do
    it 'belongs to a student' do
      expect(vote.student).to eq student
    end

    it 'belongs to a round' do
      expect(vote.round).to eq round
    end

    it 'belongs to an idea' do 
      expect(vote.idea).to eq idea
    end

  end

  describe "validations" do
    xit 'student can only vote 3 times per round' do

    end

    xit 'student cannot vote for same idea in same round' do
    end
  end


end
