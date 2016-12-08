require 'rails_helper'

RSpec.describe Cohort, type: :model do
  let(:city) { City.create(name: "San Diego") }
  let(:cohort) { Cohort.create(name: "chipmunks-2016", city_id: city.id) }

  describe "attributes" do
    it 'has a name' do
      expect(cohort.name).to eq "chipmunks-2016"
    end

    it 'has a current phase default to ideas' do
      expect(cohort.current_phase).to eq "ideas"
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
      expect(cohort.rounds).to include round
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

  describe "validations" do
    it 'must have a name' do
      invalid_cohort = Cohort.create(city_id: city.id)
      expect(invalid_cohort.errors[:name].first).to eq "can't be blank"
    end

    it 'must belongs to a valid city' do
      invalid_cohort = Cohort.create(city_id: 3)
      expect(invalid_cohort.errors[:city].last).to eq "can't be blank"
    end

    it 'must has a unique name within the city' do
      valid_cohort = Cohort.create(name: "chipmunks-2016", city_id: city.id)
      invalid_cohort = Cohort.create(name: "chipmunks-2016", city_id: city.id)
      expect(invalid_cohort.errors[:name].first).to eq "has already been taken"
    end
  end

  describe "#next_phase" do
    it 'switch cohort to next phase' do
      cohort.next_phase
      expect(cohort.current_phase).to eq "voting"
    end

    it 'stops changing phase when cohort is finished' do
      cohort.update_attribute(:current_phase, "finished")
      cohort.next_phase
      expect(cohort.current_phase).to eq "finished"
    end
  end

  describe "#current_round" do
    it 'returns current round if cohort is in voting' do
      cohort.next_phase
      expect(cohort.current_round).to eq 1
    end

    it 'returns 0 for other phases' do
      expect(cohort.current_round).to eq 0
    end
  end
end
