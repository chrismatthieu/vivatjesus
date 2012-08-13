Vivatjesus::Application.routes.draw do



  resources :payments

  match '/calendar' => 'pages#calendar'
  # match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  match '/posts/rss' => 'posts#rss'
  match '/events/rss' => 'events#rss'
  match '/password/:id' => 'users#password'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
  
  get "errors/404"
  get "errors/500"

  # Omniauth pure
  match "/signin" => "sessions#signin"
  match "/signout" => "sessions#signout"

  match '/auth/:service/callback' => 'sessions#create' 
  match '/auth/failure' => 'sessions#failure'
  match '/auth/:provider' => "application#omniauth"
  match '/feed' => "users#feed"
  match '/activity' => "users#allfeed"
  match '/councilfeed' => "users#councilfeed"
  match '/activity/:id' => "users#showfeed"
  match '/twitter' => "users#twitter"
  match '/facebook' => "users#facebook"
  match '/deauthtwitter' => "users#deauthtwitter"
  match '/deauthfacebook' => "users#deauthfacebook"

  match ':user/following' => 'follows#index', :view => 'following', :constraints => { :user => /[0-9A-Za-z\-\_\@\.\%20]+/ }
  match ':user/followers' => 'follows#index', :view => 'followers', :constraints => { :user => /[0-9A-Za-z\-\_\@\.\%20]+/ }
  match '/users/pollallfeed' => 'users#pollallfeed'
  match '/users/pollfeed' => 'users#pollfeed'
  match '/users/polluserfeed/:userid' => 'users#polluserfeed'
  match '/statuses/pollfeed' => 'statuses#pollfeed'
  match '/follows/block/:id' => 'follows#block'
  match '/follows/unblock/:id' => 'follows#unblock'
  

  match '/login' => 'sessions#new'
  match '/logout' => 'sessions#destroy'
  match '/about' => 'pages#about'
  match '/join' => 'pages#join'
  match '/pages/contact' => 'pages#contact'
  match '/search' => 'posts#search'
  match '/mobile' => 'pages#mobile'
  match '/news' => 'pages#news'
  match '/success' => 'pages#success'
  match '/users/password' => "users#password"
  match ':user/edit' => 'users#edit'
  match 'search/:username' => 'users#search'

  match '/mobile/home' => 'mobile#index'
  match '/mobile/about' => 'mobile#about'
  match '/mobile/news' => 'mobile#news'
  match '/mobile/calendar' => 'mobile#calendar'

  resources :events
  resources :posts
  resources :users
  resources :sessions
  resources :password_resets
  resources :sponsors
  resources :councils
  resources :statuses
  resources :follows
  

  match ':user' => 'users#show', :constraints => { :user => /[0-9A-Za-z\-\_\@\.\%20]+/ }
  
  match '*a', :to => 'errors#404'


  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'pages#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
