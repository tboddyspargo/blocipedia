# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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