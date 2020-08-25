Rails.application.routes.draw do
  devise_for :users
  get 'home/about'
  root 'tops#top'
  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update]
  resources :users

end
