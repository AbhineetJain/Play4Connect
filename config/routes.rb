Rails.application.routes.draw do
  get 'images/code_image/:id', :controller => 'images', :action => 'code_image'
  
  resources :images
  
  get 'sessions/login'

  get 'sessions/home'

  get 'sessions/profile'

  get 'sessions/setting'

  get 'sessions/leaderboard'

  get 'sessions/playgame'

  post 'sessions/submit_score'

  get 'sessions/send_mail'

  get 'users/new'

  post 'sessions/login_attempt'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'users#new'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  resources :users
  resources :sessions
  root :to => "sessions#login"
  match "signup", :to => "users#new", :via => :get
  match "login", :to => "sessions#login", :via => :get
  match "invite", :to => "sessions#send_mail", :via => :get
  match "submit", :to => "sessions#submit_score", :via => :post
  match "logout", :to => "sessions#logout", :via => :get
  match "home", :to => "sessions#home", :via => :get
  match "profile", :to => "sessions#profile", :via => :get
  match "view_scores", :to => "sessions#setting", :via => :get
  match "leaderboard", :to => "sessions#leaderboard", :via => :get
  match "playgame", :to => "sessions#playgame", :via => :get
  
  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
