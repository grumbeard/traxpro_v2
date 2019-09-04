require 'faker'
require 'csv'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Destroying all previous Users..."
Category.destroy_all
SubCategory.destroy_all
Issue.destroy_all
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
  puts "Creating 5 maps for #{new_project.name}"
  5.times do
    new_map = Map.new(
      project: new_project,
      title: Faker::Space.galaxy,
    )
    new_map.save
  end
end

puts "Creating 20 new project solvers"
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

puts "Creating Categories and SubCategories"

filepath = 'db/categories.csv'
structure = []
architecture = []
mep = []
ff_e = []

CSV.foreach(filepath) do |row|
  structure << row[0]
  architecture << row[1]
  mep << row[2]
  ff_e << row[3]
end

new_structure_category = Category.new(name: structure[0])
new_structure_category.save

new_architecture_category = Category.new(name:  architecture[0])
new_architecture_category.save

new_mep_category = Category.new(name: mep[0])
new_mep_category.save

new_ff_e_category = Category.new(name: ff_e[0])
new_ff_e_category.save


structure[1..-1].each do |sub_cat|
  struc_sub_category = SubCategory.new(name: sub_cat, category: new_structure_category)
  struc_sub_category.save
end

architecture[1..-1].each do |sub_cat|
  archi_sub_category = SubCategory.new(name: sub_cat, category: new_architecture_category)
  archi_sub_category.save
end

mep[1..-1].each do |sub_cat|
  mep_sub_category = SubCategory.new(name: sub_cat, category: new_mep_category)
  mep_sub_category.save
end

ff_e[1..-1].each do |sub_cat|
  ff_e_sub_category = SubCategory.new(name: sub_cat, category: new_ff_e_category)
  ff_e_sub_category.save
end

puts "Creating 10 issues"
10.times do
  new_issue = Issue.new(
    map: Map.all.sample,
    x_coordinate: rand(1..10),
    y_coordinate: rand(1..10),
    title: Faker::Book.title,
    project: Project.all.sample,
    )
  new_issue.save
  new_categorization = Categorization.new(issue: new_issue, sub_category: SubCategory.all.sample)
  new_categorization.save
end

puts "Creating 20 issue solvers"
20.times do
    new_issue_solver = IssueSolver.new(
    issue: Issue.all.sample,
    project_solver: ProjectSolver.all.sample,
  )
  new_issue_solver.save
end
