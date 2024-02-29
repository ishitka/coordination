Rails.application.routes.draw do

  namespace :admin do
    get 'relationships/followings'
    get 'relationships/followers'
  end
  
  namespace :public do
    get 'relationships/followings'
    get 'relationships/followers'
  end
  get 'relationships/followings'
  get 'relationships/followers'
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  scope module: :public do
    root to:'homes#top' do
      
    end
  end
  
  namespace :admin do
    get 'search' => 'searches#search'
  end
  
  namespace :admin do
    resources :posts, only: [:index, :show, :edit, :update, :destroy]
  end
  
  namespace :admin do
    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only:[:create, :destroy]
        get 'followings' => 'relationships#followings', as: 'followings'
        get 'followers' => 'relationships#followers', as: 'followers'
    end
  end
  
  namespace :admin do
    get 'admin'=>'homes#top',as: 'top'
  end
  
  scope module: :public do
    resources :posts, omly: [:new, :create, :edit, :show, :update, :destroy] do
      resource :favorite, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
  end
  
  scope module: :public do
    get 'search' => 'searches#search'
  end
  

  scope module: :public do
    get '/users/confirm' => 'users#confirm', as: 'confirm_user'
    patch '/users/withdraw' => 'users#withdraw',as:'withdraw_user'
    resources :users, only: [:show, :edit, :update] do
      member do
        get :favorites
      end
      resource :relationships, only:[:create, :destroy]
        get 'followings' => 'relationships#followings', as: 'followings'
        get 'followers' => 'relationships#followers', as: 'followers'
    end
  end
  
  
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
