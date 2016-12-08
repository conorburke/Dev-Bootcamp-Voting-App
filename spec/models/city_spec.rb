require 'rails_helper'

RSpec.describe City, type: :model do
  let(:city) { City.create(name: "San Diego") }
  describe 'attributes' do
    it 'has a name' do
      expect(city.name).to eq('San Diego')
    end
  end

  describe 'associations' do
    it 'has many teachers' do
      teacher = Teacher.create(first_name: "Kevin", last_name: "Solorio", email: "kevin@devbootcamp.com", access_code: "kevins", city_id: city.id)
      expect(city.teachers.first).to eq teacher
    end

    it 'has many cohorts' do
      cohort = Cohort.create(name: "chipmunks-2016", city_id: city.id)
      expect(city.cohorts.first).to eq cohort
    end

    it 'has many students' do
      cohort = Cohort.create(name: "chipmunks-2016", city_id: city.id)
      student = Student.create(first_name: "Chelsey", last_name: "Lin", email: "chelseylin@gmail.com", access_code: "chelseyl", cohort_id: cohort.id)
      expect(city.students.first).to eq student
    end
  end

  describe 'validations' do
    it 'must have a name' do
      invalid_city = City.create
      expect(invalid_city.errors[:name].first).to eq "can't be blank"
    end

    it 'must have a unique name' do
      valid_city = City.create(name: "San Diego")
      invalid_city = City.create(name: "San Diego")
      expect(invalid_city.errors[:name].first).to eq "has already been taken"
    end
  end
end
