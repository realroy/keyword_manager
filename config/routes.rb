# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users

  namespace :api do
    resources :keywords, only: %w[index show] do
      put :upload, on: :collection
    end
  end

  namespace :keywords do
    resource :upload, only: %w[show update]
  end
  resources :keywords, only: %w[index show]

  root 'keywords#index'
end
