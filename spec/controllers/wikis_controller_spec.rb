require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:member) { create(:user) }
  let(:my_wiki) { create(:wiki) }
  
  describe "anonymous access" do
    
    describe "GET #index" do
      it "returns http auth error" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe "GET #show" do
      it "returns http auth error" do
        get :show, id: my_wiki.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  
    describe "GET #new" do
      it "returns http auth error" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  
    describe "GET #edit" do
      it "returns http auth error" do
        get :edit, id: my_wiki.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
  
  context "member access" do
    before do
      sign_in(member)  
    end
    
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
      
      it "returns http success" do
        get :index
        expect(assigns(:wikis)).to eq Wiki.all
      end
    end
    
    describe "GET #show" do
      it "returns http success" do
        get :show, id: my_wiki.id
        expect(response).to have_http_status(:success)
      end
      
      it "instantiates a wiki object" do
        get :show, id: my_wiki.id
        expect(assigns(:wiki)).to_not be_nil
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
  
    describe "GET #edit" do
      it "returns http success" do
        get :edit, id: my_wiki.id
        expect(response).to have_http_status(:success)
      end
      
      it "finds and instantiates wiki object" do
        get :edit, id: my_wiki.id
        expect(assigns(:wiki)).to eq my_wiki
      end
    end
  end

end
