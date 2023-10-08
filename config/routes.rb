Rails.application.routes.draw do
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  resources :spots do
    collection do
      get 'search'
    end
  end
  resources :users, only:[:show, :destroy]

  get '/policy', to: 'application#policy'
  
  # Defines the root path route ("/")
  root to: "spots#index"

end
