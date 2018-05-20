
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

FactoryBot.define do
  factory :wiki do
    title { Faker::Lorem.sentence.titlecase }
    body { fake_markdown_body }
    
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
