require 'faker'

5.times do
  User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    password: "password"
  )
end
User.create!(
  name: "David Alderson",
  email: "dsa027@gmail.com",
  password: "password"
)
User.create!(
  name: "Denise Alderson",
  email: "denclam@gmail.com",
  password: "password"
)
users = User.all

50.times do
  body = ''
  5.times do
    body += Faker::Company.bs.capitalize + ". "
  end
  Wiki.create!(
    title: Faker::Science.element,
    body: body,
    private: Faker::Boolean.boolean,
    user: users.sample
  )
end

p "#{User.all.count} users created."
p "#{Wiki.all.count} wikis created."
