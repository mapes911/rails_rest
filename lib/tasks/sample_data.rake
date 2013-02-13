namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_experiences
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "example@railstutorial.org",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_experiences
  users = User.all(limit: 10)
  20.times do
    title = Faker::Lorem.words(7).join(" ")
    moral = Faker::Lorem.words(5).join(" ")
    users.each { |user| user.experiences.create!(title: title, moral: moral) }
  end

  experiences = Experience.all()
  5.times do
    title = Faker::Lorem.words(5).join(" ")
    body = Faker::Lorem.paragraphs(3).join(" ")
    experiences.each { |experience| experience.chapters.create!(title: title, body: body) }
  end

end