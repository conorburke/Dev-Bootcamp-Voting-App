# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

City.delete_all
Cohort.delete_all
Teacher.delete_all
Student.delete_all
Idea.delete_all
Group.delete_all

city = City.create(name: "San Diego")
cohort = Cohort.create(name: "chipmunks", city_id: city.id)
teacher = Teacher.create(first_name: "Kevin", last_name: "Solorio", email: "kevin@devbootcamp.com", city_id: city.id)
student = Student.create(first_name: "John", last_name: "Smith", email: "jsmith@gmail.com", cohort_id: cohort.id)
idea = Idea.create(title: "good idea", student_id: student.id)

idea1 = Idea.create(title: "good idea1", student_id: student.id)
idea2 = Idea.create(title: "good idea2", student_id: student.id)
idea3 = Idea.create(title: "good idea3", student_id: student.id)
idea4 = Idea.create(title: "good idea4", student_id: student.id)

ideas = [idea,idea1,idea2,idea3,idea4]
groups = []
for i in 0...4
  groups << Group.create(name: Faker::Superhero.name, idea_id: ideas[i].id)
end
p groups
for i in 0...20
  puts i/5
  group = groups[i/5]
  group.students.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, cohort_id: cohort.id)
end
