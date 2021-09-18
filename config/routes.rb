Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html  
  root 'home#index'
  
  devise_for :users, controllers: { registrations: 'registrations' }
  
  devise_scope :user do
    patch 'users/update_password', to: 'registrations#update_password', as: :update_user_password
    get '/unsubscribe_from_premium', to: 'registrations#unsubscribe_from_premium', as: :unsubscribe_from_premium
  end
  
  # Making subscription purchases.
  resources :charges, only: [:new, :create]
  resources :collaborators, only: [:create, :destroy]
  
  resources :wikis
  
  # for rendering markdown text in html via HTTP request.
  post "/markdown" => 'wikis#preview', as: :markdown
end
