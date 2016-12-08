require 'rails_helper'

RSpec.describe Idea, type: :model do
  let(:city) { City.create(name: "San Diego") }
  let(:cohort) { Cohort.create(name: "chipmunks", city_id: city.id) }
  let(:student) { Student.create(first_name: "Conor", last_name: "Burke", email: "conor@gmail.com", cohort_id: cohort.id) }
  let(:idea) { Idea.create(title: "idea", student_id: student.id) }
  let(:choice) { Choice.create(student_id: student.id, idea_id: idea.id, preference_level: 1)}

  describe "attributes" do
    it 'has a title' do
      expect(idea.title).to eq "idea"
    end
  end

  describe "associations" do
    it 'belongs to a student' do
      expect(idea.student).to eq student
    end

    it 'has a cohort' do
      expect(idea.cohort).to eq cohort
    end

    it 'has a group' do
      group = Group.create(name: "group 1", idea_id: idea.id)
      expect(idea.group).to eq group
    end

    it 'has many choices' do
      expect(idea.choices).to include(choice)
    end

    it 'has many votes' do
      round = Round.create(voting_round: 1, cohort_id: cohort.id)
      vote = Vote.create(student_id: student.id, idea_id: idea.id, round_id: round.id)
      expect(idea.votes).to include(vote)
    end

    it 'has many rounds' do
      round = Round.create(voting_round: 1, cohort_id: cohort.id)
      vote = Vote.create(student_id: student.id, idea_id: idea.id, round_id: round.id)
      expect(idea.rounds).to include(round)
    end
  end

  describe 'validations' do
    it 'must have a title' do
      invalid_idea = Idea.create(student_id: student.id)
      expect(invalid_idea.errors[:title]).to include "can't be blank"
    end

    it 'must have a valid student' do
      invalid_idea = Idea.create(student_id: student.id + 1)
      expect(invalid_idea.errors[:student]).to include "can't be blank"
    end

    it 'must have a valid cohort' do
      invalid_idea = Idea.create(student_id: student.id + 1)
      expect(invalid_idea.errors[:cohort]).to include "can't be blank"
    end

    it 'must have be unique in cohort' do
      valid_idea = Idea.create(title: "idea", student_id: student.id)
      invalid_idea = Idea.create(title: "idea", student_id: student.id)
      expect(invalid_idea.errors[:title]).to include "has already been taken"
    end
  end

  describe 'features' do
    it 'returns true if active' do
      expect(idea.active?).to eq true
    end
  end
end
