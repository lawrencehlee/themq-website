Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'about' => 'static_pages#about'

  resources :articles
  resources :top_tens
  resources :ed_pcps
  get '/' => 'static_pages#about'
end
