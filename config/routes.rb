Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :wikis

  resources :charges, only: [:new, :create, :edit, :update]

  get 'about' => 'welcome#about'
  root 'welcome#index'
end
