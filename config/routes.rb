Rails.application.routes.draw do

  root 'pages#portal'

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/register', to: "users#new"
  get '/logout', to: "sessions#destroy"
  get '/my', to: "discussions#my"
  get '/all', to: "discussions#index"
  get '/user/edit', to: "users#edit"
  get '/following', to: "discussions#following"
  patch '/user/edit', to: "users#update"

  resources :friendships, only: [:create, :destroy, :index]
  resources :messages, except: [:destroy, :index] do
    get :sent, action: :index, placeholder: 'Sent', on: :collection
    get :inbox, action: :index, placeholder: 'Inbox', on: :collection
  end
  
  resources :users, only: [:create, :show] do
    collection do
      get 'search' 
    end
  end
  resources :threads, :controller => "discussions", except: [:index] do
    put '/join', to: "discussions#join"
    delete '/leave', to: "discussions#leave"
    resources :posts, except: [:new, :index] do
        resources :comments, except: [:new, :index, :show]
    end
  end

end
