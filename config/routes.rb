Rails.application.routes.draw do
  root 'main#index'

  if Rails.env.development? or Rails.env.staging?
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
  end

  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  resources :articles do
    collection do
      get 'all'
    end
  end

  resources :ed_pcps do
    collection do
      get 'all'
    end
  end

  resources :features do
    collection do
      get 'all'
    end
  end

  resources :tags
  resources :people
  resources :top_tens do
    collection do
      get 'random'
    end
  end

  get 'search', to: 'search#index'

  # error pages
  get "/404", :to => "errors#not_found"
  get "/500", :to => "errors#internal_server_error"
end
