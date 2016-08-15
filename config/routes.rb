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

  # error pages
  
  resources :errors
  %w( 404 422 500 503 ).each do |code|
    get code, :to => "errors#index", :code => code
  end
end
