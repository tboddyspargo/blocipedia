require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:confirmed_user) }
  
  context "validations" do
    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:email) }
    
    it { is_expected.to allow_value("me@here.com").for(:email) }
    
    it { is_expected.to_not allow_value("me.com").for(:email) }
    
    
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
    it { is_expected.to validate_length_of(:first_name).is_at_most(20) }
    it { is_expected.to validate_length_of(:last_name).is_at_most(20) }
  end
  
  context "relationships" do
    it { is_expected.to have_many(:wikis) }
  end
end
