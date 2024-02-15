Rails.application.routes.draw do
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    resources :postes, only: [:index, :show, :edit, :update, :destroy]
  end
  namespace :admin do
    resources :users, only: [:show, :edit, :update]
  end
  namespace :admin do
    get 'admin'=>'homes#top',as: 'top'
  end
  
  scope module: :public do
    resources :favorites, only: [:index]
  end
  
  scope module: :public do
    resources :posts, omly: [:new, :create, :edit, :show, :update, :destroy]
  end
  
  scope module: :public do
    get '/searches/search' => 'searches#search', as: 'searches'
  end
    
  scope module: :public do
    get '/users/confirm' => 'users#confirm', as: 'confirm_user'
    patch '/users/withdraw' => 'users#withdraw',as:'withdraw_user'
    resources :users, only: [:show, :edit, :update]
  end
  
  scope module: :public do
    root to:'homes#top'
  end
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
