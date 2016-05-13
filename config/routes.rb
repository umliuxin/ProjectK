Rails.application.routes.draw do

  get 'game_room/show'

  # Login process
  get 'login' => 'welcomepage#show'
  post 'login' => 'welcomepage#login'
  delete 'logout' => 'welcomepage#logout'
  # Game list page
  get 'game_list' => 'game_list#show'
  post 'create_game' => 'game_list#create_game'
  post 'join_game' => 'game_list#join_game'

  # Game room page

  get 'game_room' => 'game_room#show'
  get 'exit' =>'game_room#exit'
  get 'killer_win' => 'game_room#killer_win'
  get 'killer_lose' => 'game_room#killer_lose'
  get 'cancel_game' => 'game_room#cancel_game'

  root to: 'welcomepage#show'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

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
