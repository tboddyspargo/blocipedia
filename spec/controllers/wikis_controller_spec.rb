require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let!(:member) { create(:user) }
  let!(:other_member) { create(:user) }
  let!(:my_wiki) { member.wikis.create!(attributes_for(:wiki, private: false)) }
  let!(:other_private_wiki) { other_member.wikis.create!(attributes_for(:wiki, private: true)) }
  
  context "common access" do
    
    describe "GET #index" do
      before(:each) { get :index }
      
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      
      it "instantiates wiki object" do
        expect(assigns(:wikis)).to eq Wiki.public_ones
      end
    end
    
    describe "GET #show" do
      before(:each) { get :show, id: my_wiki.id }
      
      it "returns http success for public wiki" do
        expect(response).to have_http_status(:success)
      end
      
      it "instantiates wiki object" do
        expect(assigns(:wiki)).to_not be_nil
      end
    end
  end
  
  context "anonymous access" do
    
    context "private wiki" do
      
      describe "GET #show" do
        it "redirects to #index for private wiki" do
          get :show, id: other_private_wiki.id
          expect(response).to redirect_to(wikis_path)
        end
      end
    end
  
    describe "GET #new" do
      before(:each) { get :new }
      
      it "redirects to #signin" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  
    describe "GET #edit" do
      before(:each) { get :edit, id: my_wiki.id }
      
      it "redirects to #signin" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe "POST #create" do
      before(:each) do
        wiki_attr = attributes_for(:wiki)
        post :create, wiki: wiki_attr
      end
      
      it "redirects to #signin" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe "POST #create causes" do
      before(:each) { @wiki_attr = attributes_for(:wiki) }
      
      it "does not increase Wiki count" do
        expect{post :create, wiki: @wiki_attr}.to change(Wiki, :count).by(0)
      end
    end
    
    describe "PUT #update" do
      before(:each) do
        @wiki_attr = attributes_for(:wiki)
        put :update, id: my_wiki.id, wiki: @wiki_attr
        @updated_wiki = assigns(:wiki)
      end
      
      it "redirects to #index" do
        expect(response).to redirect_to(wikis_path)
      end
      
      it "does not change attributes" do
        expect(@updated_wiki[:title]).to_not eq(@wiki_attr[:title])
        expect(@updated_wiki[:body]).to_not eq(@wiki_attr[:body])
      end
    end
    
    describe "DELETE #destroy" do
      before(:each) { delete :destroy, id: other_private_wiki.id }
      
      it "redirects to #index" do
        expect(response).to redirect_to(wikis_path)
      end
    end
  end
  
  context "member access" do
    before do
      sign_in(member)  
    end
    
    describe "GET #new" do
      before(:each) { get :new }
      
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      
      it "instantiates wiki object" do
        expect(assigns(:wiki)).to_not be_nil
      end
    end
    
    describe "POST #create" do
      before(:each) do
        wiki_attr = attributes_for(:wiki)
        post :create, wiki: wiki_attr
      end
      
      it "assigns Wiki.last to @wiki" do
        expect(assigns(:wiki)).to eq(Wiki.last)
      end
      
      it "redirects to #show" do
        expect(response).to redirect_to Wiki.last
      end
    end
    
    describe "POST #create invalid" do
      before(:each) do
        @wiki_attr = { title: 'a', body: 'b' }
        post :create, wiki: @wiki_attr
      end
      
      it "renders #new with invalid attribute" do
        expect(response).to render_template(:new)
      end
    end
    
    describe "POST #create causes" do
      before(:each) { @wiki_attr = attributes_for(:wiki) }
      it "increases count of wikis by 1" do
        expect{post :create, wiki: @wiki_attr}.to change(Wiki,:count).by(1)
      end
    end
    
    context "member's own wiki" do
    
      describe "GET #show" do
        before(:each) { get :show, id: my_wiki.id }
        it "returns http success" do
          expect(response).to have_http_status(:success)
        end
      end
    
      describe "GET #edit" do
        before(:each) do
          get :edit, id: my_wiki.id
        end
        
        it "returns http success" do
          expect(response).to have_http_status(:success)
        end
        
        it "instantiates wiki object" do
          expect(assigns(:wiki)).to eq my_wiki
        end
      end
        
      describe "PUT #update" do
        before(:each) do
          @wiki_attr = attributes_for(:wiki)
          put :update, id: my_wiki.id, wiki: @wiki_attr
          @updated_wiki = assigns(:wiki)
        end
        
        it "changes attributes" do
          expect(@updated_wiki[:title]).to eq(@wiki_attr[:title])
          expect(@updated_wiki[:body]).to eq(@wiki_attr[:body])
        end
      
        it "assigns updated wiki to @wiki" do
          expect(@updated_wiki).to eq(Wiki.find(my_wiki.id))
        end
        
        it "redirects to #show" do
          expect(response).to redirect_to my_wiki
        end
      end
      
      describe "PUT #update invalid" do
        before(:each) do
          @wiki_attr = { title: 'a', body: 'b' }
          put :update, id: my_wiki.id, wiki: @wiki_attr
        end
        
        it "renders #edit with invalid attribute" do
          expect(response).to render_template(:edit)
        end
      end
      
      describe "DELETE #destroy" do
        before(:each) { delete :destroy, id: my_wiki.id }
        
        it "redirects to #index" do
          expect(response).to redirect_to(wikis_path)
        end
      end
      
      describe "DELETE #destroy causes" do
        it "decrease wiki count by 1" do
          expect{delete :destroy, id: my_wiki.id}.to change(Wiki, :count).by(-1)
        end
      end
    end
    
    context "private wiki owned by another" do
      
      describe "GET #show" do
        before(:each) { get :show, id: other_private_wiki.id }
        
        it "redirects to #index" do
          expect(response).to redirect_to(wikis_path)
        end
      end
    
      describe "GET #edit" do
        before(:each) { get :edit, id: other_private_wiki.id }
        
        it "redirects to #index" do
          expect(response).to redirect_to(wikis_path)
        end
      end
      
      describe "PUT #update" do
        before(:each) do
          @wiki_attr = attributes_for(:wiki)
          put :update, id: other_private_wiki.id, wiki: @wiki_attr
        end
        
        it "redirects to #index" do
          expect(response).to redirect_to(wikis_path)
        end
      end
      
      describe "DELETE #destroy" do
        before(:each) { delete :destroy, id: other_private_wiki.id }
        
        it "redirects to #index" do
          expect(response).to redirect_to(wikis_path)
        end
      end
    end
    
  end

end
