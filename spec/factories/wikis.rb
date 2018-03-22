FactoryBot.define do
  factory :wiki do
    title Faker::Lorem.words(4, true).join(' ')
    body Faker::Lorem.paragraphs(4, true).join('\n')
    private Faker::Boolean.boolean
    user User.all.sample
  end
end
