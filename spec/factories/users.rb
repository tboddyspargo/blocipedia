FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
  end
  
  factory :confirmed_user, :parent => :user do
    after(:build)   { |u| u.skip_confirmation_notification! }
    confirmed_at Date.today
  end
  
end