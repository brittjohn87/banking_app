Rails.application.routes.draw do
  root 'dashboard#all_accounts'
  get 'deposit' => 'accounts#deposit'
  get 'withdrawal' => 'accounts#withdrawal'
  post 'update_balance' => 'accounts#update_balance'
  get 'transfer' => 'accounts#transfer'
  post 'complete_transfer' => 'accounts#complete_transfer'

  resources :accounts
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
