Rails.application.routes.draw do
  root 'dashboard#all_accounts'

  resources :accounts
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
