require 'rails_helper'

RSpec.describe Wiki, type: :model do
  context "attributes" do
    it { should belong_to(:user) }
  end
  
  context "validations" do
    it { should validate_presence_of(:user) }
    
    it { should validate_length_of(:title).is_at_least(8) }
    it { should validate_length_of(:title).is_at_most(140) }
    
    it { should validate_length_of(:body).is_at_least(8) }
    it { should validate_length_of(:body).is_at_most(20000) }
    
    it { should allow_value(Faker::Boolean.boolean).for(:private) }
  end
end
