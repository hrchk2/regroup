Rails.application.routes.draw do
  # ユーザー用
  # URL /users/sign_in ...
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about"
    resources :users, only: [:show,:edit,:update] do
        member do
        get :favorites
        end
        resource :relationships, only: [:create, :destroy]
        get "following" => "relationships#following"
        get "followers" => "relationships#followers"
    end
    get "users/:id/quit" => "users#quit",as: :quit_user
    patch "users/:id/withdraw" => "users#withdraw",as: :withdraw_user
    resources :posts, only: [:new,:index,:create,:show,:edit,:update,:destroy] do
      resource:favorites,only:[:create,:destroy]
      resources:comments,only: [:create,:destroy]
    end
    get "posts/tag/:name",to: "posts#tag"
  end

  namespace :admin do
    get "/" => "homes#top"
    resources :users, only: [:index,:show,:edit,:update]
    resources :posts, only: [:index,:show,:destroy] do
      resources:comments, only: [:destroy]
    end
    resources :tags, only: [:index,:destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
