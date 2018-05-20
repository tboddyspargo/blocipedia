require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  let(:standard) { create(:confirmed_user, role: 'standard') }
  let!(:premium) { create(:confirmed_user, role: 'premium') }
  let!(:private_wiki) { create(:wiki, owner: premium, private: true) }
  
  # before do
  #   @request.env["devise.mapping"] = Devise.mappings[:user]
  # end
  
  context "anonymous" do
    context "GET #unsubscribe_from_premium" do
      before(:each) { get :unsubscribe_from_premium }
      subject { response }
      
      it { is_expected.to redirect_to new_user_session_path }
    end
  end
  
  context "standard" do
    before { sign_in(standard) }
    
    context "GET #unsubscribe_from_premium" do
      before(:each) { get :unsubscribe_from_premium }
      subject { response }
      
      it { is_expected.to redirect_to edit_user_registration_path }
      
      describe "role" do
        subject { User.find(standard.id) }
        it { is_expected.to have_attributes( role: 'standard' ) }
      end
    end
  end
  
  context "premium" do
    before { sign_in(premium) }
    
    context "GET #unsubscribe_from_premium" do
      before(:each) { get :unsubscribe_from_premium }
      subject { response }
      
      it { is_expected.to redirect_to edit_user_registration_path }
    
      describe "role" do
        subject { User.find(standard.id) }
        it { is_expected.to have_attributes( role: 'standard' ) }
      end
      
      describe "wiki" do
        subject { Wiki.find(private_wiki.id) }
        it { is_expected.to have_attributes( private: false ) }
      end
    end
  end
  
end