Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :wikis

  get 'about' => 'welcome#about'
  root 'welcome#index'
end
