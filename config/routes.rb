Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  get 'about' => 'welcome#about'
  root 'welcome#index'
end
