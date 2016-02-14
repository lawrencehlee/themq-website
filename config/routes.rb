Rails.application.routes.draw do
  get 'about' => 'static_pages#about'

  resources :articles
  resources :top_tens
  resources :ed_pcps
  get '/' => 'static_pages#about'
end
