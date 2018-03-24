require 'rails_helper'

RSpec.describe User, type: :model do
  context "attributes" do
    it { should have_many(:wikis) }
  end
end
