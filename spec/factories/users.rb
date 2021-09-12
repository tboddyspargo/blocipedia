FactoryBot.define do
  factory :user, aliases: [:owner] do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { "password" }
    password_confirmation { "password" }
    role { User.roles.values.sample }
  end
  
  factory :confirmed_user, aliases: [:confirmed_owner], :parent => :user do
    after(:build)   { |u| u.skip_confirmation_notification! }
    confirmed_at { Date.today }
  end
end
