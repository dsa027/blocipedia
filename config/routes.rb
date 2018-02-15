Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :wikis
  resources :collaborators, only: [:create, :destroy]

  resources :charges, only: [:new, :create, :edit, :update]

  get 'about' => 'welcome#about'
  root 'welcome#index'
end
