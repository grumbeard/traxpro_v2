Rails.application.routes.draw do
  get 'maps/show'
  get 'maps/new'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects, only: [:index, :show, :new, :create] do
    resources :maps, only: [:new, :create]
  end

  resources :maps, only: [:show]
end
