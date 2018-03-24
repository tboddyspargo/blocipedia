require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:member) { create(:user) }
  let(:other_member) { create(:user) }
  let(:my_wiki) { create(:wiki, private: false, user: member) }
  let(:other_private_wiki) { create(:wiki, private: true, user: other_member) }
  
  context "common access" do
    
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
      
      it "instantiates wiki object" do
        get :index
        expect(assigns(:wikis)).to eq Wiki.public_ones
      end
    end
    
    describe "GET #show" do
      it "returns http success for public wiki" do
        get :show, id: my_wiki.id
        expect(response).to have_http_status(:success)
      end
      
      it "instantiates wiki object" do
        get :show, id: my_wiki.id
        expect(assigns(:wiki)).to_not be_nil
      end
    end
  end
  
  context "anonymous access" do
    
    describe "GET #show" do
      it "redirects to #index for private wiki" do
        get :show, id: other_private_wiki.id
        expect(response).to redirect_to(wikis_path)
      end
      
    end
  
    describe "GET #new" do
      it "redirects to #signin" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  
    describe "GET #edit" do
      it "redirects to #signin" do
        get :edit, id: my_wiki.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe "POST #create" do
      it "redirects to #signin" do
        new_wiki = attributes_for(:wiki)
        post :create, wiki: new_wiki
        expect(response).to redirect_to(new_user_session_path)
      end
      
      it "does not increase Wiki count" do
        new_wiki = attributes_for(:wiki)
        expect{post :create, wiki: new_wiki}.to change(Wiki, :count).by(0)
      end
    end
    
    describe "PUT #update" do
      it "redirects to #index" do
        new_wiki = attributes_for(:wiki)
        put :update, id: my_wiki.id, wiki: new_wiki
        expect(response).to redirect_to(wikis_path)
      end
      
      it "does not update wiki" do
        new_wiki = attributes_for(:wiki)
        put :update, id: my_wiki.id, wiki: new_wiki
        expect(assigns(:wiki)).to_not have_attributes(new_wiki)
      end
    end
  end
  
  context "member access" do
    before do
      sign_in(member)  
    end
    
    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
      
      it "instantiates wiki object" do
        get :new
        expect(assigns(:wiki)).to_not be_nil
      end
    end
    
    describe "POST #create" do
      it "increases count of wikis by 1" do
        new_wiki = attributes_for(:wiki)
        expect{post :create, wiki: new_wiki}.to change(Wiki,:count).by(1)
      end
      
      it "assigns Wiki.last to @wiki" do
        new_wiki = attributes_for(:wiki)
        post :create, wiki: new_wiki
        expect(assigns(:wiki)).to eq(Wiki.last)
      end
      
      it "redirects to #show" do
        new_wiki = attributes_for(:wiki)
        post :create, wiki: new_wiki
        expect(response).to redirect_to Wiki.last
      end
      
      it "renders #new and flashes :alert invalid attribute" do
        new_wiki = { title: 'a', body: 'b' }
        post :create, wiki: new_wiki
        expect(flash[:alert]).to_not be_nil
        expect(response).to render_template(:new)
      end
    end
    
    context "member's own private wiki" do
    
      describe "GET #show" do
        it "returns http success" do
          get :show, id: my_wiki.id
          expect(response).to have_http_status(:success)
        end
      end
    
      describe "GET #edit" do
        it "returns http success" do
          get :edit, id: my_wiki.id
          expect(response).to have_http_status(:success)
        end
        
        it "instantiates wiki object" do
          get :edit, id: my_wiki.id
          expect(assigns(:wiki)).to eq my_wiki
        end
      end
        
      describe "PUT #update" do
        it "changes attributes" do
          new_wiki = attributes_for(:wiki)
          put :update, id: my_wiki.id, wiki: new_wiki
          expect(assigns(:wiki)).to have_attributes(new_wiki)
        end
      
        it "assigns updated wiki to @wiki" do
          new_wiki = attributes_for(:wiki)
          put :update, id: my_wiki.id, wiki: new_wiki
          expect(assigns(:wiki)).to eq(Wiki.find(my_wiki.id))
        end
        
        it "redirects to #show" do
          new_wiki = attributes_for(:wiki)
          put :update, id: my_wiki.id, wiki: new_wiki
          expect(response).to redirect_to my_wiki
        end
        
        it "renders #edit and flashes :alert invalid attribute" do
        new_wiki = { title: 'a', body: 'b' }
        put :update, id: my_wiki.id, wiki: new_wiki
        expect(flash[:alert]).to_not be_nil
        expect(response).to render_template(:edit)
        end
      end
    end
    
    context "private wiki owned by another" do
      describe "GET #show" do
        it "redirects to #index" do
          get :show, id: other_private_wiki.id
          expect(response).to redirect_to(wikis_path)
        end
        
        it "flashes :alert" do
          get :edit, id: other_private_wiki.id
          expect(flash[:alert]).to_not be_nil
        end
      end
    
      describe "GET #edit" do
        it "redirects to #index" do
          get :edit, id: other_private_wiki.id
          expect(response).to redirect_to(wikis_path)
        end
      end
      
      describe "PUT #update" do
        it "redirects to #index" do
          new_wiki = attributes_for(:wiki)
          put :update, id: other_private_wiki.id, wiki: new_wiki
          expect(response).to redirect_to(wikis_path)
        end
      end
    end
    
  end

end
