Rails.application.routes.draw do
  get 'about' => 'static_pages#about'

    resources :articles
end
