FactoryBot.define do
  factory :collaborator do
    wiki_id { Wiki.sample.id }
    user_id { User.sample.id }
  end
end