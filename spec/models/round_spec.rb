require 'rails_helper'

RSpec.describe Round, type: :model do
  let(:city) { City.create(name: "San Diego") }
  let(:cohort) { Cohort.create(name: "chipmunks", city_id: city.id) }
  let(:round) { Round.create(voting_round: 1, cohort_id: cohort.id) }
  let(:student) { Student.create(first_name: "Conor", last_name: "Burke", email: "conor@gmail.com", access_code: '1234', cohort_id: cohort.id) }
  let(:idea) { Idea.create(title: "idea", student_id: student.id, active: 1) }
  let(:vote) { Vote.create(student_id: student.id, idea_id: idea.id, round_id: round.id) }
  
  describe "attributes" do
    it 'has a voting round' do
      expect(round.voting_round).to eq 1
    end

    it 'has a cohort_id' do 
      expect(round.cohort_id).to eq cohort.id
    end

    it 'has a default voting round value of 1' do 
      default_round = Round.create(cohort_id: 1)
      expect(round.voting_round).to eq 1
    end
  end

  describe "associations" do 
    it 'belongs to a cohort' do 
      expect(round.cohort).to eq cohort
    end

    it 'has many votes' do 
      expect(round.votes).to include(vote)
    end

    it 'has many ideas' do 
      p vote
      p round 
      p idea
      expect(round.ideas).to include(idea)
    end
  end

  

end
