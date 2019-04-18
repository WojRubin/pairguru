Rails.application.routes.draw do

  devise_for :users

  root "home#welcome"
  resources :genres, only: :index do
    member do
      get "movies"
    end
  end

  resources :comments, only: [:create, :destroy]
 
  get '/commenters' => 'commenters#index'

  resources :movies, only: [:index, :show] do
    resources :comments , only: [:index, :create]
    member do
      get :send_info
    end
    collection do
      get :export
    end
  end

  namespace :api do 
    namespace :v1 do 
      resources :movies, only: [:index,:show]
    end
  end
end
