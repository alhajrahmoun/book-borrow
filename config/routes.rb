Rails.application.routes.draw do
  root 'dashboard#index'
  get 'dashboard/index'
  get 'books/search', to: 'books#search'
  get 'users/need_approval', to: 'users#need_approval'
  get 'users/control_approval', to: 'users#control_approval'
  get 'books/books_borrows', to: 'books#books_borrows'
  get 'books/need_approval', to: 'books#need_approval'
  get 'books/control_approval', to: 'books#control_approval'
  resources :penalties do 
    get :autocomplete_user_first_name, :on => :collection
  end
  resources :users
    resources :categories do 
      resources :subcategories
      resources :books do
        member do 
          get 'subscribe'
          get 'unsubscribe'
        end
        get :autocomplete_user_first_name, :on => :collection
        get :autocomplete_sub_category_name, :on => :collection
        resources :reviews
    end
    end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api do
    get 'home', to: 'books#home'
    get 'favorite_books', to: 'books#favorite_books'
    get 'most_borrowed', to: 'books#most_borrowed'
    get 'books/search', to: 'books#search'
    get 'users/get_info', to: 'users#get_info'
    get 'users/save_fcm_token', to: 'users#save_fcm_token'
  	resources :users do 
      resources :notifications
    end 
  	resources :categories do 
  		resources :subcategories
      resources :books do
         member do 
          get 'subscribe'
          get 'unsubscribe'
        end
        resources :reviews
    end
  	end
  end
end
