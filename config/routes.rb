Rails.application.routes.draw do

  root 'pages#portal'

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/register', to: "users#new"
  get '/logout', to: "sessions#destroy"
  get '/user/edit', to: "users#edit"
  get '/following', to: "discussions#following"
  patch '/user/edit', to: "users#update"

  post '/post/:id/like', as: 'post_like', type: 'Post',  to: "likes#create"
  post '/comment/:id/like', as: 'comment_like', type: 'Comment', to: "likes#create"
  delete '/post/:id/like', as: 'delete_post_like', type: 'Post',  to: "likes#destroy"
  delete '/comment/:id/like', as: 'delete_comment_like', type: 'Comment', to: "likes#destroy"

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
    post :create, to: "discussion_members#create"
    delete :destroy, to: "discussion_members#destroy"
    get :all, action: :index, type: 'all', on: :collection
    get :my, action: :index, type: 'my', on: :collection
    get :following, action: :index, type: 'following', on: :collection

  end

  resources :posts, except: [:new, :index] do
    resources :comments, except: [:new, :index, :show]
  end

end
