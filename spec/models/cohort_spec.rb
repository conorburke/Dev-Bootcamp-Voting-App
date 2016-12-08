require 'rails_helper'

RSpec.describe Cohort, type: :model do
  let(:city) { City.create(name: "San Diego") }
  let(:cohort) { Cohort.create(name: "chipmunks-2016", city_id: city.id) }
  
  describe "attributes" do
    it 'has a name' do
      expect(cohort.name).to eq "chipmunks-2016"
    end
  end

  describe "associations" do
    it 'belongs to a city' do
      expect(cohort.city).to eq city
    end

    it 'has many students' do
      student = Student.create(first_name: "Chelsey", last_name: "Lin", email: "chelseylin@gmail.com", access_code: "chelseyl", cohort_id: cohort.id)
      expect(cohort.students.first).to eq student
    end

    it 'has many teachers' do
      teacher = Teacher.create(first_name: "Kevin", last_name: "Solorio", email: "kevin@devbootcamp.com", access_code: "kevins", city_id: city.id)
      expect(cohort.teachers.first).to eq teacher
    end

    it 'has many rounds' do
      round = Round.create(cohort_id: cohort.id)
      expect(cohort.rounds.first).to eq round
    end

    it 'has many ideas' do
      student = Student.create(first_name: "Chelsey", last_name: "Lin", email: "chelseylin@gmail.com", access_code: "chelseyl", cohort_id: cohort.id)
      idea = Idea.create(title: "final idea", student_id: student.id)
      expect(cohort.ideas.first).to eq idea
    end

    it 'has many groups' do
      student = Student.create(first_name: "Chelsey", last_name: "Lin", email: "chelseylin@gmail.com", access_code: "chelseyl", cohort_id: cohort.id)
      idea = Idea.create(title: "final idea", student_id: student.id)
      group = Group.create(name: "Group 1", idea_id: idea.id)
      student.group = group
      expect(cohort.groups.first).to eq group
    end
  end
end
