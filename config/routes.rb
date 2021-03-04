Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root to: "items#index"
  resources :cards, only: [:new, :create]
  resources :users, only: [:show, :edit, :destroy, :update]
  resources :items do
    resources :purchases, only: [:index, :create]
  end

end
