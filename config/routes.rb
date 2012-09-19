PrivatePrisons::Application.routes.draw do
  resources :reports do
    collection do
      get 'inmate'
      get 'accountability'
      get 'incident'
      post 'generate'
    end
    member do
    end
  end
  resources :homes
  resources :uploads
  resources :prompts
  resources :pppams_reviews
  resources :pppams_report_filters
  resources :pppams_references
  resources :pppams_issues
  resources :pppams_issue_follow_ups
  resources :pppams_indicators
  resources :pppams_indicator_base_refs
  resources :pppams_category_base_refs
  resources :position_histories
  resources :notifications
  resources :notification_reports
  resources :notification_receivers
  resources :non_comp_issues
  resources :non_comp_follow_ups
  resources :investigators
  resources :inmate_counts
  resources :incidents
  resources :incident_investigators
  resources :follow_ups
  resources :employee_position_histories
  resources :position_numbers
  resources :positions
  resources :position_types
  resources :contexts
  resources :accountability_log_details
  resources :accountability_logs
  resources :pppams_category_groups
  resources :incident_types
  resources :incident_classes
  resources :action_types
  resources :custody_types
  resources :user_types
  resources :employees
  resources :facilities
  resources :access_levels
  devise_for :users

  root :to => "homes#index"
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
