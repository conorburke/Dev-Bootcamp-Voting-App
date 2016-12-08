require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:city) { City.create(name: "San Diego") }
  let(:cohort) { Cohort.create(name: "chipmunks-2016", city_id: city.id) }
  let(:student) { Student.create(first_name: "Conor", last_name: "Burke", email: "conor@gmail.com", cohort_id: cohort.id) }
  let(:idea) { Idea.create(title: "idea", student_id: student.id) }
  let(:group) { Group.create(name: "group 1", idea_id: idea.id) }

  describe "attributes" do
    it 'has a name' do
      expect(group.name).to eq "group 1"
    end
  end

  describe "associations" do
    it 'belongs to an idea' do
      expect(group.idea).to eq idea
    end

    it 'has many students' do
      student.group = group
      student.save
      expect(group.students).to include student
    end

    it 'has a cohort' do
      student.group = group
      student.save
      expect(group.cohort).to eq cohort
    end
  end

  describe "validations" do
    it 'must have a name' do
      invalid_group = Group.create()
      expect(invalid_group.errors[:name]).to include "can't be blank"
    end

    it 'must have an idea' do
      invalid_group = Group.create(name: "group 1")
      expect(invalid_group.errors[:idea]).to include "can't be blank"
    end

    it 'must has a unique idea' do
      valid_group = Group.create(name: "group 1", idea_id: idea.id)
      invalid_group = Group.create(name: "group 2", idea_id: idea.id)
      expect(invalid_group.errors[:idea]).to include "has already been taken"
    end
  end

  describe "features" do
    it 'auto generate name' do
      group = Group.create(idea_id: idea.id)
      expect(group.name).to eq "group 1"
    end
  end
end
