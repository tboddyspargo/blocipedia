FactoryBot.define do
  factory :wiki do
    title Faker::Lorem.words(4, true).join(' ').titlecase
    body Faker::Lorem.paragraphs(4, true).map! { |i| "<p>#{i}</p>" }.join
    private Faker::Boolean.boolean
    user User.all.sample
  end
end
