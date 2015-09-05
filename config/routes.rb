Rails.application.routes.draw do

  resources :permissions
  get 'projects/add_user', to: 'projects#add_user'
  post 'projects/process_req', to: 'projects#process_req'

  get 'projects/revoke_user', to: 'projects#revoke_user'
  post 'projects/revoke_req', to: 'projects#revoke_req'

  get 'projects/add_issue', to: 'projects#add_issue'
  post 'projects/process_add_issue', to: 'projects#process_add_issue'

  get 'projects/close_issue', to: 'projects#close_issue'
  get 'projects/assign_to', to: 'projects#assign_to'
  post 'projects/assign_to_process', to: 'projects#assign_to_process'

  get 'projects/add_comment', to: 'projects#add_comment'
  post 'projects/process_comment', to: 'projects#process_comment'

  resources :projects
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'projects#index'

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
