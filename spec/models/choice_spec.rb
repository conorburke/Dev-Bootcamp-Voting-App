require 'rails_helper'

RSpec.describe Choice, type: :model do
  let(:city) { City.create(name: "San Diego") }
  let(:cohort) { Cohort.create(name: "Chipmunks", city_id: city.id) }
  let(:student) { Student.create(first_name: "Tae", last_name: "Yun", email: "tj@gmail.com", cohort_id: cohort.id) }
  let(:idea) { Idea.create(title: "new idea", student_id: student.id) }
  let(:choice) { Choice.create(student_id: student.id, idea_id: idea.id, preference_level: 1) }

  describe "associations" do
    it 'belongs to a student' do
      expect(choice.student).to eq student
    end

    it 'belongs to a student' do
      expect(choice.idea).to eq idea
    end
  end

  describe "validations" do
    it 'must belongs to a student' do
      invalid_choice = Choice.create(idea_id: idea.id, preference_level: 1)
      expect(invalid_choice.errors[:student]).to include "can't be blank"
    end

    it 'must belongs to an idea' do
      invalid_choice = Choice.create(student_id: student.id, preference_level: 1)
      expect(invalid_choice.errors[:idea].last).to eq "can't be blank"
    end

    it 'must have a preference_level' do
      invalid_choice = Choice.create(student_id: student.id, idea_id: idea.id)
      expect(invalid_choice.errors[:preference_level]).to include "can't be blank"
    end

    it 'must has a preference level greater or equal to 1' do
      invalid_choice = Choice.create(student_id: student.id, idea_id: idea.id, preference_level: 0)
      expect(invalid_choice.errors[:preference_level].first).to eq "must be greater than or equal to 1"
    end

    it 'student cannot have duplicate preference level' do
      idea = Idea.create(title: "new idea", student_id: student.id)
      new_idea = Idea.create(title: "new idea 2", student_id: student.id)
      choice = Choice.create(student_id: student.id, idea_id: idea.id, preference_level: 1)
      new_choice = Choice.create(student_id: student.id, idea_id: new_idea.id, preference_level: 1)
      expect(new_choice.errors.full_messages).to include("Preference level cannot be the same")
    end

    it 'student cannot vote multiple times on same idea' do
      choice = Choice.create(student_id: student.id, idea_id: idea.id, preference_level: 1)
      new_choice = Choice.create(student_id: student.id, idea_id: idea.id, preference_level: 2)
      expect(new_choice.errors.full_messages).to include("Idea should not be chosen more than once")
    end

    it 'must has a preference level in range' do
      invalid_choice = Choice.create(student_id: student.id, idea_id: idea.id, preference_level: 2)
      expect(invalid_choice.errors[:preference_level].first).to eq "cannot exceed total number of options"
    end
  end
end
