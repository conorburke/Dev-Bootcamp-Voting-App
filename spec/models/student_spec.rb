require 'rails_helper'

RSpec.describe Student, type: :model do
  let(:student) { Student.create(first_name: "Tae", last_name: "Yun", email: "tj@gmail.com") }
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
  end

  describe "methods" do
    it 'has a full_name' do
      expect(student.full_name).to eq "Tae Yun"
    end
  end

  describe "associations" do
    it 'has many ideas' do
      expect(student.ideas).to include(idea)
    end

    it 'has many votes' do
      vote = Vote.create(student_id: student.id, idea_id: idea.id)
      expect(student.votes).to include(vote)
    end

    it 'has many choices' do
      choice = Choice.create(student_id: student.id, idea_id: idea.id, preference_level: 1)
      expect(student.choices).to include(choice)
    end
  end
end
