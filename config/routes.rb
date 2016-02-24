Rails.application.routes.draw do

	root 'main#index'
  get 'about' => 'static_pages#about'

  resources :articles
  resources :top_tens
  resources :ed_pcps
end
