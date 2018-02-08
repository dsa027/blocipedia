Rails.application.routes.draw do
  get 'charges/create'

  get 'charges/new'

  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :wikis

  resources :charges, only: [:new, :create, :edit, :update]

  get 'about' => 'welcome#about'
  root 'welcome#index'
end
