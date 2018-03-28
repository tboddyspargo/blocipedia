require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let!(:member) { create(:user) }
  let!(:other_member) { create(:user) }
  let!(:attr) { attributes_for(:wiki, private: false) }
  let!(:other_attr) { attributes_for(:wiki, private: true) }
  let!(:updated_attr) { attributes_for(:wiki) }
  let!(:invalid_attr) { { title: 'a', body: 'b' } }
  let!(:my_wiki) { member.wikis.create!(attr) }
  let!(:other_private) { other_member.wikis.create!(other_attr) }
  
  context "common access" do
    context "GET #index" do
      before(:each) { get :index }
      
      subject { response }
      it { is_expected.to have_http_status(:success) }
      
      describe "contents" do
        subject { assigns(:wikis) }
        it { is_expected.to exist }
      end
    end
    
    context "GET #show" do
      before(:each) { get :show, id: my_wiki.id }
      
      subject { response }
      it { is_expected.to have_http_status(:success) }
      
      describe "@wiki" do
        subject { assigns(:wiki) }
        it { is_expected.to eq(my_wiki) }
      end
    end
  end
  
  context "anonymous access" do
    
    context "GET #new" do
      before(:each) { get :new }
      
      subject { response }
      it { is_expected.to redirect_to(new_user_session_path) }
    end
    
    context "private wiki" do
      
      context "GET #show" do
        before(:each) { get :show, id: other_private.id }
        
        subject { response }
        it { is_expected.to redirect_to(wikis_path) }
      end
      
      context "GET #edit" do
        before(:each) { get :edit, id: my_wiki.id }
        
        subject { response }
        it { is_expected.to redirect_to(new_user_session_path) }
      end
    end
  
    context "POST #create" do
      before(:each) { post :create, wiki: attr }
      
      subject { response }
      it { is_expected.to redirect_to(new_user_session_path) }
      
      it { expect{post :create, wiki: attr}.to change(Wiki, :count).by(0) }
    end
    
    
    context "PUT #update" do
      before(:each) { put :update, id: my_wiki.id, wiki: updated_attr }
      
      subject { response }
      it { is_expected.to redirect_to(wikis_path) }
      
      describe "result" do
        subject { Wiki.find(my_wiki.id) }
        it { is_expected.to_not have_attributes(title: updated_attr[:title], body: updated_attr[:body]) }
      end
    end
    
    context "DELETE #destroy" do
      before(:each) { delete :destroy, id: other_private.id }
      
      subject { response }
      it { is_expected.to redirect_to(wikis_path) }
    end
  end
  
  context "member access" do
    before do
      sign_in(member)  
    end
    
    context "GET #new" do
      before(:each) { get :new }
      
      subject { response }
      it { is_expected.to have_http_status(:success) }
      
      describe "@wiki" do
        subject { assigns(:wiki) }
        it { is_expected.to_not exist }
      end
    end
    
    context "POST #create" do
      
      context "valid" do
        before(:each) { post :create, wiki: attr }
        
        subject { response }
        it { is_expected.to redirect_to(wiki_path(Wiki.last))}
        
        it { expect{ post :create, wiki: updated_attr }.to change(Wiki,:count).by(1) }
      end
      
      context "invalid" do
        before(:each) { post :create, wiki: invalid_attr }
        
        subject { response }
        it { is_expected.to render_template(:new) }
        
        it { expect{post :create, wiki: invalid_attr}.to change(Wiki,:count).by(0) }
      end
    end
    
    context "own wiki" do
    
      context "GET #show" do
        before(:each) { get :show, id: my_wiki.id }
        subject { response }
        it { is_expected.to have_http_status(:success) }
        
        describe "@wiki" do
          subject { assigns(:wiki) }
          it { is_expected.to eq(my_wiki) }
        end
      end
    
      context "GET #edit" do
        before(:each) { get :edit, id: my_wiki.id }
        
        subject { response }
        it { is_expected.to have_http_status(:success) }
        
        describe "@wiki" do
          subject { assigns(:wiki) }
          it { is_expected.to eq(my_wiki) }
        end
      end
        
      context "PUT #update" do
        context "valid" do
          before(:example) { put :update, id: my_wiki.id, wiki: updated_attr }
          
          subject { response }
          it { is_expected.to redirect_to my_wiki }
          
          describe "result" do
            subject { Wiki.find(my_wiki.id) }
            it { is_expected.to have_attributes(title: updated_attr[:title], body: updated_attr[:body]) }
          end
        end
        
        context "invalid" do
          before(:each) { put :update, id: my_wiki.id, wiki: invalid_attr }
          
          subject { response }
          it { is_expected.to render_template(:edit) }
          
          describe "result" do
            subject { Wiki.find(my_wiki.id) }
            it { is_expected.to_not have_attributes(title: invalid_attr[:title], body: invalid_attr[:body]) }
          end
        end
      end
      
      context "DELETE #destroy" do
        before(:each) { delete :destroy, id: my_wiki.id }
        
        subject { response }
        it { is_expected.to redirect_to(wikis_path) }
      end
      
      context "DELETE #destroy result" do
        it { expect{ delete :destroy, id: my_wiki.id }.to change(Wiki, :count).by(-1) }
      end
    end
    
    context "other's private wiki" do
      
      context "GET #show" do
        before(:each) { get :show, id: other_private.id }
        
        subject { response }
        it { is_expected.to redirect_to(wikis_path) }
      end
    
      context "GET #edit" do
        before(:each) { get :edit, id: other_private.id }
        
        subject { response }
        it { is_expected.to redirect_to(wikis_path) }
      end
      
      context "PUT #update" do
        before(:each) { put :update, id: other_private.id, wiki: attr }
        
        subject { response }
        it { is_expected.to redirect_to(wikis_path) }
      end
      
      context "DELETE #destroy" do
        before(:each) { delete :destroy, id: other_private.id }
        
        subject { response }
        it { is_expected.to redirect_to(wikis_path) }
      end
      
      context "DELETE #destroy result" do
        it { expect{ delete :destroy, id: other_private.id }.to change(Wiki, :count).by(0) }
      end
    end
    
  end

end
