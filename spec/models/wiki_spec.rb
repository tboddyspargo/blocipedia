require 'rails_helper'

RSpec.describe Wiki, type: :model do
  context "attributes" do
    it { should belong_to(:user) }
  end
  
  context "validations" do
    it { should allow_value(Faker::Lorem.words(4, true).join.capitalize).for(:title) }
    it { should allow_value(Faker::Lorem.paragraphs(4, true).join('\n')).for(:title) }
    it { should allow_value(Faker::Boolean).for(:title) }
  end
end
