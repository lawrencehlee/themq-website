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
      get 'test'
		end
	end

  resources :top_tens


end
