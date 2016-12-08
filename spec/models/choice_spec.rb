require 'rails_helper'

RSpec.describe Choice, type: :model do
  let(:student) { Student.create(first_name: "Tae", last_name: "Yun", email: "tj@gmail.com") }
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
    it 'student cannot have duplicate preference level' do
      new_idea = Idea.create(title: "new idea 2", student_id: student.id)
      new_choice = Choice.create(student_id: student.id, idea_id: new_idea.id, preference_level: 1)
      expect(new_choice.errors.full_messages).to include("Preference level cannot be the same")
    end

    it 'student cannot vote multiple times on same idea' do
      new_choice = Choice.create(student_id: student.id, idea_id: idea.id, preference_level: 2)
      expect(new_choice.errors.full_messages).to include("Idea should not be chosen more than once")
    end
  end
end
