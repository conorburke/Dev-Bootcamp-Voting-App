# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

city = City.create(name: "San Diego")
cohort = Cohort.create(name: "chipmunks", city_id: city.id)
teacher = Teacher.create(first_name: "Kevin", last_name: "Solorio", email: "kevin@devbootcamp.com", city_id: city.id)
student = Student.create(first_name: "John", last_name: "Smith", email: "jsmith@gmail.com", cohort_id: cohort.id)
idea = Idea.create(title: "good idea", student_id: student.id)
