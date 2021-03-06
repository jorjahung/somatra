Somatra::Application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  get 'blood-tests' => 'blood_tests#index', as: :blood_tests
  get 'blood-tests/new' => 'blood_tests#new', as: :new_blood_test
  post 'blood-tests' => 'blood_tests#create'
  get 'blood-tests/legend'=> 'blood_tests#legend', as: :blood_tests_legend
  get 'blood-tests/omnigraph' => 'blood_tests#omnigraph', as: :omnigraph
  get 'blood-tests/:id' => 'blood_tests#show', as: :blood_test
  get 'blood-tests/:id/edit' => 'blood_tests#edit', as: :edit_blood_test
  patch 'blood-tests/:id' => 'blood_tests#update', as: :update_blood_test
  get 'blood-tests/results/:name'=> 'blood_tests#results'
  delete 'blood-tests/:id' => 'blood_tests#destroy', as: :delete_blood_test
  get "moods" => 'moods#index', as: :moods
  post "moods" => 'moods#create'
  get 'moves/callback' => 'dashboard#moves_callback'

  # You can have the root of your site routed with "root"
  root 'dashboard#index'

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
