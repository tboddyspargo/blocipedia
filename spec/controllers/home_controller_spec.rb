require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:user) { create(:confirmed_user) }
  
  describe 'anonymous access' do
    context "GET #index" do
      before(:each) { get :index }
      subject { response }
      it { is_expected.to have_http_status(:success) }
    end
  end
end
