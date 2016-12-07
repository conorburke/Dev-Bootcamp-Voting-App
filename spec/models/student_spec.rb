require 'rails_helper'

RSpec.describe Student, type: :model do
  let(:student) { Student.new(first_name: "Tae", last_name: "Yun", email: "tj@gmail.com") }

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
end
