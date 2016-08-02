Rails.application.routes.draw do
	root 'main#index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'about' => 'static_pages#about'
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

  # redirecting any unknown route to top ten random
  # it is important that this is at the bottom of this file
  if Rails.env.production?
    get '*path', :to => 'top_tens#random'
  end
end
