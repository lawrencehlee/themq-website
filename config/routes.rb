Rails.application.routes.draw do
  get 'about' => 'static_pages#about'

  resources :articles
  get '/' => 'static_pages#about'
end
