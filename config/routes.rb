Theindy::Application.routes.draw do

  match "/wp-login" => redirect("http://students.brown.edu/College_Hill_Independent/wp-login"), :status => 302
  match "/wp-admin" => redirect("http://students.brown.edu/College_Hill_Independent/wp-login"), :status => 302

  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users

  match 'admin', :to => 'admin#index'

  namespace :admin do
    resources :article
    resources :issues
    resources :archive
    resources :thelists
    match 'emails'
  end

  devise_scope :user do
    match "/login" => "devise/sessions#new"
  end

  match 'search', :to => 'pages#search'
  match 'author', :to => 'pages#author'
  match 'illustrator', :to => 'pages#illustrator'
  match 'email', :to => 'pages#email'
  match 'about', :to => 'pages#about'
  match 'masthead', :to => 'pages#masthead'
  match 'apply', :to => 'pages#apply'
  match 'list', :to => 'pages#list'
  match 'subscribe', :to => 'pages#subscribe'

  match 'feed', :to => 'home#feed', :as => :feed
  match 'issues', :to => 'home#issue_feed', :as => :issues
  match 'toc/:id', :to => 'issue#toc'

  match '/:id', :to => 'article#show'
  match 'a/:id', :to => 'article#show_a'
  match 'i/:id', :to => 'issue#show'

  root :to => 'home#index'
  unless Rails.application.config.consider_all_requests_local
      match '*not_found', to: 'pages#not_found'
  end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
