require 'rails_helper'

RSpec.describe Student, type: :model do
  let(:city) { City.create(name: "San Diego") }
  let(:cohort) { Cohort.create(name: "Chipmunks", city_id: city.id) }
  let(:student) { Student.create(first_name: "Tae", last_name: "Yun", email: "tj@gmail.com", cohort_id: cohort.id) }
  let(:idea) { Idea.create(title: "new idea", student_id: student.id) }

  describe "attributes" do
    it 'has a first_name' do
      expect(student.first_name).to eq "Tae"
    end

    it 'has a last_name' do
      expect(student.last_name).to eq "Yun"
    end

    it 'has a email' do
      expect(student.email).to eq "tj@gmail.com"
    end

    it 'has an access_code' do
      student.save
      expect(student.access_code).to_not eq nil
    end

    it 'has a current_access' do
      student.update_attribute(:current_access, "ideas")
      expect(student.current_access).to eq "ideas"
    end
  end

  describe "methods" do
    it 'has a full_name' do
      expect(student.full_name).to eq "Tae Yun"
    end

    it 'returns true for assigned if has a group' do
      group = Group.create(name: "group 1", idea_id: idea.id)
      student.update_attribute(:group_id, group.id)
      expect(student.assigned?).to eq true
    end

    it 'returns false if not assigned' do
      expect(student.assigned?).to eq false
    end

    it 'authenticates' do
      expect(student.authenticate(student.access_code)).to eq student
    end
  end

  describe "associations" do
    it 'belongs to a cohort' do
      expect(student.cohort).to eq cohort
    end

    it 'belongs to a group' do
      group = Group.create(name: "group 1", idea_id: idea.id)
      student.update_attribute(:group_id, group.id)
      expect(student.group).to eq group
    end

    it 'has many ideas' do
      expect(student.ideas).to include(idea)
    end

    it 'has many votes' do
      round = Round.create(voting_round: 1, cohort_id: cohort.id)
      vote = Vote.create(student_id: student.id, idea_id: idea.id, round_id: round.id)
      expect(student.votes).to include(vote)
    end

    it 'has many choices' do
      choice = Choice.create(student_id: student.id, idea_id: idea.id, preference_level: 1)
      expect(student.choices).to include(choice)
    end
  end
end
