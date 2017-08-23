# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Car.delete_all
Car.create!(make: 'Toyota', model: 'Camry', year: 2015, vin: 'A0000000000000001')
Car.create!(make: 'Honda', model: 'Civic', year: 2014, vin: 'A0000000000000002')
Car.create!(make: 'Suburu', model: 'Outback', year: 2013, vin: 'A0000000000000003')