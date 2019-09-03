Rails.application.routes.draw do
  get 'issues/index'
  get 'issues/new'
  get 'maps/show'
  get 'maps/new'
  devise_for :users
  root to: 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects, only: [:index, :show, :new, :create] do
    member do # member will append :id to URI
      get :solvers
    end
    resources :maps, only: [:new, :create]
    resources :project_solvers, only: [:create]
  end

  resources :maps, only: [:show]
end


