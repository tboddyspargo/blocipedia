require 'rails_helper'

RSpec.describe ChargesController, type: :controller do
  let(:user) { create(:confirmed_user) }
  
  context "annonymous" do
    context "GET #new" do
      before(:each) { get :new }
      subject { response }
      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end
  
  context "member" do
    before { sign_in(user) }
    context "GET #new" do
      before(:each) { get :new }
      subject { response }
      it { is_expected.to have_http_status(:success) }
    end
  end
  

end
