require 'rails_helper'

RSpec.describe Teacher, type: :model do
  let(:city) { City.create(name: "San Diego") }
  let(:cohort) { Cohort.create(name: "Chipmunks", city_id: city.id) }
  let(:teacher) { Teacher.create(first_name: "Kevin", last_name: "Solorio", email: "kevin@devbootcamp.com", city_id: city.id) }
  let(:student) { Student.create(first_name: "Tae", last_name: "Yun", email: "tj@gmail.com", cohort_id: cohort.id) }
  let(:idea) { Idea.create(title: "new idea", student_id: student.id) }

  describe "attributes" do
    it 'has a first_name' do
      expect(teacher.first_name).to eq "Kevin"
    end

    it 'has a last_name' do
      expect(teacher.last_name).to eq "Solorio"
    end

    it 'has a email' do
      expect(teacher.email).to eq "kevin@devbootcamp.com"
    end

    it 'has an access_code' do
      expect(teacher.access_code).to_not eq nil
    end
  end

  describe "methods" do
    it 'has a full_name' do
      expect(teacher.full_name).to eq "Kevin Solorio"
    end

    it 'authenticates' do
      expect(teacher.authenticate(teacher.access_code)).to eq teacher
    end
  end

  describe "associations" do
    it 'belongs to a city' do
      expect(teacher.city).to eq city
    end

    it 'has many cohorts' do
      expect(teacher.cohorts).to include cohort
    end

    it 'has many students' do
      expect(teacher.students).to include student
    end
  end

  describe "validations" do
    it 'must have a first name' do
      invalid_teacher = Teacher.create(last_name: "Solorio", email: "kevin@devbootcamp.com", city_id: city.id)
      expect(invalid_teacher.errors[:first_name]).to include "can't be blank"
    end

    it 'must have a last name' do
      invalid_teacher = Teacher.create(first_name: "Kevin", email: "kevin@devbootcamp.com", city_id: city.id)
      expect(invalid_teacher.errors[:last_name]).to include "can't be blank"
    end

    it 'must have an email' do
      invalid_teacher = Teacher.create(first_name: "Kevin", last_name: "Solorio", city_id: city.id)
      expect(invalid_teacher.errors[:email]).to include "can't be blank"
    end

    it 'must have a valid city' do
      invalid_teacher = Teacher.create(first_name: "Kevin", last_name: "Solorio", email: "kevin@devbootcamp.com")
      expect(invalid_teacher.errors[:city]).to include "can't be blank"
    end
  end
end
