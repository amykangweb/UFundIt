# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
100.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'password',
    admin: nil,
    )
end

User.create(
name: 'admin',
email: 'admin@example.com',
password: 'password',
admin: true,
)

10.times do
  Deal.create(
    title: Faker::Lorem.sentence(rand(3..15)),
    image: 'image/path',
    description: Faker::Lorem.paragraph(1),
    goal: 10,
    location: 'Seattle, WA',
    start: Faker::Time.between(2.days.ago, Time.now, :all),
    end: Faker::Time.forward(30),
    amount: 25,
    owner_id: User.all.sample.id,
    published: true,
    )
end

10.times do
  Deal.create(
    title: Faker::Lorem.sentence(rand(3..15)),
    image: 'image/path',
    description: Faker::Lorem.paragraph(1),
    goal: 10,
    location: 'Seattle, WA',
    start: Faker::Time.between(2.days.ago, Time.now, :all),
    end: Faker::Time.forward(30),
    amount: 25,
    owner_id: User.all.sample.id,
    published: true,
    private: true,
    )
end

10.times do
  Deal.create(
    title: Faker::Lorem.sentence(rand(3..15)),
    image: 'image/path',
    description: Faker::Lorem.paragraph(1),
    goal: 10,
    location: 'Seattle, WA',
    start: Faker::Time.between(60.days.ago, Time.now, :all),
    end: Faker::Time.forward(30),
    amount: 25,
    owner_id: User.all.sample.id,
    published: true,
    private: true,
    )
end


40.times do
  Commitment.create(
    payment: 10,
    deal_id: Deal.all.sample.id,
    user_id: User.all.sample.id,
  )
end
