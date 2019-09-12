require 'faker'
require 'csv'
require 'pry-byebug'

puts "Destroying all Categories, Issues and Users..."

Issue.destroy_all
puts "Destroyed all issues"

User.destroy_all
puts "Destroyed all users"

Category.destroy_all
puts "Destroyed all categories"


puts "Creating User 'Jimmy'"
jimmy = User.new(
  email: 'jimmy@traxpro.com',
  password: 'password',
  first_name: 'Jimmy',
  last_name: 'Wong'
)
jimmy.save

puts "Creating CoCRE8 Project for 'Jimmy'"
photo_file_names = ['waterfront.jpg', 'terminal.jpg', 'residence.jpg']
1.times do
  new_project = Project.new(
    user: jimmy,
    name: "CoCRE8",
    description: "CoCRE8 is a dynamic and inspiring co-working platform, ideal for entrepreneurs & freelancers, inviting collaboration, knowledge, and more.",
    photo: Pathname.new(Rails.root.join('app/assets/images/cocre8-event-hall.jpg')).open
  )
  new_project.save
  puts "Creating 1 map for #{new_project.name}"
  new_map = Map.new(
    project: new_project,
    title: "Level 8 Event Hall - Le Wagon",
    photo: Pathname.new(Rails.root.join('app/assets/images/cocr8_2.png')).open
  )
  new_map.save
  puts "Creating 3 maps for #{new_project.name}"
  3.times do |j|
    new_map = Map.new(
      project: new_project,
      title: "Unit #{rand(10..500)}#{%w(A B C D).sample} Level #{j + 1}",
      photo: Pathname.new(Rails.root.join("app/assets/images/floorplan1.jpg")).open
    )
    new_map.save
  end
end

puts "Creating 3 more Projects for 'Jimmy'"
project_names = ['Greater Southern Waterfront Condo', 'Changi Airport Terminal 6', 'Wagon Residences']
3.times do |i|
  new_project = Project.new(
    user: jimmy,
    name: project_names[i],
    description: "#{Faker::IndustrySegments.sector}: #{Faker::Marketing.buzzwords}",
    photo: Pathname.new(Rails.root.join("app/assets/images/#{photo_file_names[i]}")).open
  )
  new_project.save
  puts "Creating 3 maps for '#{new_project.name}'"
  3.times do |j|
    new_map = Map.new(
      project: new_project,
      title: "Unit #{rand(10..500)}#{%w(A B C D).sample} Level #{j + 1}",
      photo: Pathname.new(Rails.root.join("app/assets/images/floorplan1.jpg")).open
    )
    new_map.save
  end
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

puts "Creating 100 new issues"

issue_prefix = [
  "defective",
  "broken",
  "leaking",
  "spoilt",
  "cracked",
  "missing",
  "unfinished",
  "sagging",
  "dampness in",
  "condensation mould along",
  "damaged",
  "poor workmanship in",
  "collapsed",
  "wood rot in",
  "mould in",
  "fungus in",
  "termite infestation in"]

issue_suffix = [
  "paint",
  "roof framework",
  "water ingress",
  "brickwork",
  "plumbing",
  "waterworks",
  "building material",
  "foundation wall",
  "drainage systems",
  "cooling system",
  "insulation",
  "fire protection supression system"]

100.times do
  date_created = DateTime.now - rand(15..188)
  resolved = false
  accepted = false

  resolved = rand > 0.3
  if resolved == true
    date_resolved = date_created + rand(3..30)
    accepted = rand > 0.7
    if accepted == true
      date_accepted = date_resolved + rand(7..60)
    end
  end

  new_issue = Issue.new(
    map: Map.all.sample,
    x_coordinate: rand(1..30),
    y_coordinate: rand(1..30),
    title: "#{issue_prefix.sample} #{issue_suffix.sample}",
    project: Project.all.sample,
    resolved: resolved,
    accepted: accepted || false,
    date_created: date_created,
    deadline: date_created + rand(7..45),
    date_resolved: date_resolved,
    date_accepted: date_accepted,
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

puts "Creating 20 new Users (Solvers)"
20.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  new_user = User.new(
    password: 'password',
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name}.#{last_name}@gmail.com",
    solver: true
  )
  new_user.save
  # 1 Solver created
  new_project_solver = ProjectSolver.new(
    user: new_user,
    project: jimmy.projects.sample
  )
  new_project_solver.save
  # 1 Solver assigned to random project
  puts "Assigned #{new_user.first_name} to Project #{new_project_solver.project.name}"
  new_specialization = Specialization.new(
    sub_category: SubCategory.all.sample,
    user: new_user
  )
  new_specialization.save
end
