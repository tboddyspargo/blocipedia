# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def fake_markdown_body
  body = []
  5.times.with_index do |i|
    body << Faker::Markdown.headers << "\n"
    body << Faker::Lorem.paragraph << "\n"
    body << Faker::Markdown.random << "\n"
    body << Faker::Lorem.paragraph << "\n"
    body << Faker::Markdown.random
  end
  body.join("\n")
end

admin = User.new({
  email: 'admin@blocipedia.com',
  password: 'p@ssw0rd',
  password_confirmation: 'p@ssw0rd',
  confirmed_at: Date.today
})
admin.skip_confirmation_notification!
admin.save!

member = User.new({
  email: 'member@blocipedia.com',
  password: 'p@ssw0rd',
  password_confirmation: 'p@ssw0rd',
  confirmed_at: Date.today
})
member.skip_confirmation_notification!
member.save!

15.times do
  User.create!(
    email: Faker::Internet.email,
    password: 'p@ssw0rd',
    password_confirmation: 'p@ssw0rd',
    confirmed_at: Faker::Date.between_except(1.year.ago, 1.year.from_now, Date.today)
  )
end
users = User.all

50.times do
  wiki = Wiki.create!(
    title: Faker::Lorem.words(4, true).join(' ').titlecase,
    body: fake_markdown_body,
    private: Faker::Boolean.boolean,
    user: users.sample
  )
  
  wiki.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
end
wikis = Wiki.all

puts "Created #{users.count} users"
puts "Created #{wikis.count} wikis"