# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

def fake_markdown_body
  body = []
  5.times.with_index do |i|
    body << "## #{Faker::Lorem.words(4,true).join(' ')}" << "\n"
    body << Faker::Lorem.paragraph << "\n"
    body << Faker::Markdown.random << "\n"
    body << Faker::Lorem.paragraph << "\n"
    body << Faker::Markdown.random
  end
  body.join("\n")
end

def wiki_for_user(user)
  w = Wiki.create!(
    owner: user,
    title: Faker::Lorem.words(4, true).join(' ').titlecase,
    body: fake_markdown_body,
    private: Faker::Boolean.boolean
  )
  if w[:private]
    w.collaborators.create!(user: User.all.sample)
  end
  w
end

admin = User.new({
  email: 'admin@blocipedia.com',
  role: 'admin',
  first_name: 'Jared',
  last_name: 'Brokowski',
  password: 'p@ssw0rd',
  password_confirmation: 'p@ssw0rd',
  confirmed_at: Date.today
})
admin.skip_confirmation_notification!
admin.save!

3.times do
  wiki_for_user(admin).update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
end

premium = User.new({
  email: 'member@blocipedia.com',
  password: 'p@ssw0rd',
  role: 'premium',
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  password_confirmation: 'p@ssw0rd',
  confirmed_at: Date.today
})
premium.skip_confirmation_notification!
premium.save!

3.times do
  wiki_for_user(premium).update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
end

standard = User.new({
  email: 'user@blocipedia.com',
  password: 'p@ssw0rd',
  role: 'standard',
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  password_confirmation: 'p@ssw0rd',
  confirmed_at: Date.today
})
standard.skip_confirmation_notification!
standard.save!

3.times do
  wiki_for_user(standard).update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
end

15.times do
  user = User.create!(
    email: Faker::Internet.email,
    role: User.roles.keys.map { |k| k.to_s if k.to_s != 'admin' }.sample,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: 'p@ssw0rd',
    password_confirmation: 'p@ssw0rd',
    confirmed_at: Faker::Date.between_except(1.year.ago, 1.year.from_now, Date.today)
  )
  5.times do
    wiki_for_user(user).update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
  end
end

users = User.all
wikis = Wiki.all
collaborators = Collaborator.all

puts "Created #{users.count} users"
puts "Created #{wikis.count} wikis"
puts "Created #{collaborators.count} collaborators"
