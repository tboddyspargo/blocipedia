require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:member) { create(:user) }
  let(:other_member) { create(:user) }
  let(:my_wiki) { create(:wiki, private: false) }
  let(:other_private_wiki) { create(:wiki, private: true, user: other_member) }
  
  context "anonymous access" do
    
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
      
      it "redirects to #index for private wiki" do
        get :show, id: other_private_wiki.id
        expect(response).to redirect_to(wikis_path)
      end
      
      it "flashes :alert for private wiki" do
        get :edit, id: other_private_wiki.id
        expect(flash[:alert]).to_not be_nil
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
  end
  
  context "member access" do
    before do
      sign_in(member)  
    end
    
    context "user's own private wiki" do
    
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
    
  end

end
