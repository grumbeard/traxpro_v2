require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Destroying all previous Users..."
User.destroy_all

puts "Creating Raiser account 'Jimmy'"
jimmy = User.new(
  email: 'jimmy@traxpro.com',
  password: 'password',
  first_name: 'Jimmy',
  last_name: 'Wong'
)
jimmy.save

puts "Creating 2 Projects for 'Jimmy'"
2.times do
  new_project = Project.new(
    user: jimmy,
    name: Faker::Space.nasa_space_craft,
    description: Faker::Marketing.buzzwords
  )
  new_project.save
  puts "Creating 2 maps for #{new_project.name}"
  5.times do
    new_map = Map.new(
      project: new_project,
      title: Faker::Space.galaxy,
    )
    new_map.save
  end
end

puts "Creating 20 new Solvers"
20.times do
  new_user = User.new(
    email: Faker::Internet.email,
    password: 'password',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    solver: true
  )
  new_user.save
  new_project_solver = ProjectSolver.new(
    user: new_user,
    project: jimmy.projects.sample
  )
  new_project_solver.save
  puts "Assigned #{new_user.first_name} to Project #{new_project_solver.project.name}"
end
