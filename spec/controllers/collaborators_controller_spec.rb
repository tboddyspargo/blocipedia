require 'rails_helper'

RSpec.describe CollaboratorsController, type: :controller do
  let!(:member) { create(:confirmed_user, {role: 'standard'}) }
  let!(:premium) { create(:confirmed_user, {role: 'premium'}) }
  let!(:attr) { attributes_for(:wiki, private: false) }
  let!(:other_attr) { attributes_for(:wiki, private: true) }
  let!(:other_private) { premium.wikis.create!(other_attr) }
  let!(:my_collab) { Collaborator.create!(wiki_id: other_private.id, user_id: member.id) }
  
  before { request.env["HTTP_REFERER"] = edit_wiki_path(other_private) }
  
  context "anonymous access" do
    context "PUT#create" do
      before { put :create, params: { wiki_id: other_private.id, user: { email: member.email } } }
      subject { response }
      
      it { is_expected.to redirect_to edit_wiki_path(other_private) }
    end
    
    context "DELETE#destroy" do
      before { delete :destroy, params: { id: my_collab.id } }
      subject { response }
      
      it { is_expected.to redirect_to edit_wiki_path(other_private) }
    end
  end
  
  context "member access" do
    before { sign_in member }
    
    context "PUT#create" do
      before { put :create, params: { wiki_id: other_private.id, user: { email: member.email } } }
      subject { response }
      
      it { is_expected.to redirect_to edit_wiki_path(other_private) }
    end
    
    context "DELETE#destroy" do
      before { delete :destroy, params: { id: my_collab.id } }
      subject { response }
      
      it { is_expected.to redirect_to edit_wiki_path(other_private) }
    end
  end
  
  context "premium access" do
    before { sign_in premium }
    
    context "PUT#create" do
      before { put :create, params: { wiki_id: other_private.id, user: { email: member.email } } }
      subject { response }
      
      it { is_expected.to redirect_to edit_wiki_path(other_private) }
    end
    
    context "DELETE#destroy" do
      before { delete :destroy, params: { id: my_collab.id } }
      subject { response }
      
      it { is_expected.to redirect_to edit_wiki_path(other_private) }
    end
    
    context "DELETE#destroy causes" do
      
      it { expect{ delete :destroy, params: { id: my_collab.id } }.to change(Collaborator,:count).by(-1) }
    end
  end
end
