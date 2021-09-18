require 'faker'
I18n.reload!

module WikiFaker
  def self.markdown_body
    body = []
    rand(2..5).times.with_index do |i|
      body << "## #{Faker::Lorem.words(number: rand(2..6)).join(' ')}".titlecase << "\n"
      body << Faker::Lorem.paragraph << "\n"
      body << Faker::Markdown.random << "\n"
      body << Faker::Lorem.paragraph << "\n"
      body << Faker::Markdown.random
    end
    body.join("\n")
  end

  def self.wiki_for_user(user)
    w = Wiki.create!(
      owner: user,
      title: Faker::Lorem.words(number: rand(1..8)).join(' ').titlecase,
      body: markdown_body,
      private: Faker::Boolean.boolean
    )
    if w[:private]
      w.collaborators.create!(user: User.all.sample)
    end
    w
  end
end
