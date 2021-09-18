require 'wiki_faker'

FactoryBot.define do
  factory :wiki do
    title { Faker::Lorem.sentence.titlecase }
    body { WikiFaker::markdown_body }
    
    trait :with_owner do
      transient do
        owner { User.sample || create(:confirmed_user) }
      end
      
      after(:create) do |wiki, evaluator|
        wiki.owner = evaluator.owner
      end
    end
  end
end
