# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users

  resources :keywords, only: %w[index show]
  namespace :keywords do
    resource :upload, only: %w[show update]
  end

  root 'keywords#index'
end
