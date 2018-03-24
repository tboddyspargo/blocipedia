
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

FactoryBot.define do
  factory :wiki do
    title { Faker::Lorem.sentence.titlecase }
    body { fake_markdown_body }
    private { Faker::Boolean.boolean }
    user
  end
end
