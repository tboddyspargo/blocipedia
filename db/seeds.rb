# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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

premium = User.new({
                     email: 'member@blocipedia.com',
                     password: 'p@ssw0rd',
                     role: 'premium',
                     first_name: 'Sally',
                     last_name: 'Laker',
                     password_confirmation: 'p@ssw0rd',
                     confirmed_at: Date.today
                   })
premium.skip_confirmation_notification!
premium.save!

standard = User.new({
                      email: 'user@blocipedia.com',
                      password: 'p@ssw0rd',
                      role: 'standard',
                      first_name: 'Susan',
                      last_name: 'Fredrickson',
                      password_confirmation: 'p@ssw0rd',
                      confirmed_at: Date.today
                    })
standard.skip_confirmation_notification!
standard.save!

if !Rails.env.production?
  require 'wiki_faker'

  rand(10..20).times do
    User.create!(
      email: Faker::Internet.email,
      role: User.roles.keys.map { |k| k.to_s if k.to_s != 'admin' }.sample,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      password: 'p@ssw0rd',
      password_confirmation: 'p@ssw0rd',
      confirmed_at: Faker::Date.in_date_period
    )
  end

  users = User.all

  users.each do |u|
    rand(2..6).times do
      WikiFaker.wiki_for_user(u).update_attribute(:created_at, Faker::Date.in_date_period)
    end
  end
else
  users = User.all
end

wikis = Wiki.all
collaborators = Collaborator.all

puts "Created #{users.count} users"
puts "Created #{wikis.count} wikis"
puts "Created #{collaborators.count} collaborators"
