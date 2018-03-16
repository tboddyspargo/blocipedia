require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:user) { create(:confirmed_user) }
  
  describe 'anonymous access' do
    describe "GET #index" do
      # I'm not sure I want to force the login page right from #index, so I'll just make sure we don't get a 404.
      it "should respond to #index" do
        get :index
        expect(response).to_not have_http_status :not_found
      end
    end
  end
  
  describe 'member access' do
    before do
      sign_in(user)
    end
    
    describe "GET #index" do
      it "should respond to #index" do
        get :index
        expect(response).to have_http_status :success
      end
    end
  end
end
