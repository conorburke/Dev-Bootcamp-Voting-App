require 'rails_helper'

RSpec.describe Idea, type: :model do
  
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

  
  describe 'validations' do
    before do 
      idea_with_same_title = idea.dup
      idea_with_same_title.save
    end 

    it {should_not be_valid}
  end
end
    # it 'has a choice with a student id' do 
    #   puts idea.choices.last.student_id
    #   expect(idea.choices.last.student_id).to eq(student.id)
    # end

    # it 'has a choice with an idea id' do 
    #   expect(idea.choices.last.idea_id).to eq(idea.id)
    # end

    # it 'has a choice with a preference level' do 
    #   expect(idea.choices.to_a.last.preference_level).to eq(3)
    # end

    # it 'has a vote with a student id' do 
    #   expect(idea.choices.last.student_id).to eq(student.id)
    # end

    # it 'has a vote with an idea id' do 
    #   expect(idea.choices.last.idea_id).to eq(idea.id)
    # end

    # it 'has a vote with a preference level' do 
    #   expect(idea.choices.last.preference_level).to eq(3)
    # end

  # pending "add some examples to (or delete) #{__FILE__}"
# end
