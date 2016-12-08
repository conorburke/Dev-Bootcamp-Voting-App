require 'rails_helper'

RSpec.describe Vote, type: :model do
  let(:student) { Student.create(first_name: "Conor", last_name: "Burke", email: "conor@gmail.com") }
  let(:idea) { Idea.create(title: "idea", student_id: student.id) }
  let(:choice) {Choice.create(student_id: student.id, idea_id: idea.id, preference_level: 3)}
  let(:vote) {Vote.create(student_id: student.id, idea_id: idea.id, round: 1)}

  describe "attributes" do
    it 'has a title' do 
      expect(idea.title).to eq "idea"
    end

    it 'has a student_id' do
      expect(idea.student_id).to eq(student.id)
    end
  end

  describe "associations" do 
    it 'has a student with a first name' do 
      expect(idea.student.first_name).to eq("Conor")
    end

    it 'has a student with a last name' do 
      expect(idea.student.last_name).to eq("Burke")
    end

    it 'has a student with a email' do 
      expect(idea.student.email).to eq("conor@gmail.com")
    end

    it 'has choices' do
      expect(idea.choices).to include(choice)
    end

    it 'has votes' do 
      expect(idea.votes).to include(vote)
    end
  end


end
