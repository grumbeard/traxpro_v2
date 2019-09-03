Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :projects do
    member do # member will append :id to URI
      get :solvers
    end
    resources :project_solvers, only: [:create]
  end
end


