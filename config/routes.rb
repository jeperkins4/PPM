<<<<<<< HEAD
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
=======
ActionController::Routing::Routes.draw do |map|

  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  # map.connect '', :controller => "welcome"

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  
  map.resources :access_levels, 
                :user_types, 
                :facilities,
                :users, 
                :inmates, 
                :incident_investigators, 
                :investigators, 
                :action_types, 
                :incident_classes, 
                :incident_types, 
                :custody_types, 
                :position_types,
                :inmate_counts,
                :employee_positions,
                :employee_position_hists,
                :position_numbers,
                :positions,
                :position_hists,
                :employees,
                :prompts,
                :contexts,
                :pppams_indicator_base_refs,
                :pppams_category_base_refs,
                :pppams_references
  
  map.resources :incidents do |incidents|
     incidents.resources :follow_ups, :name_prefix => nil
  end
  
  map.editable_indicators_list '/pppams_indicators/editable_list', :controller => 'pppams_indicators', :action => 'editable_list'
  map.resources :pppams_indicators, :only => ['edit', 'show', 'new', 'create']
  map.destroy_non_comp_follow_up 'non_comp_issues/:non_comp_issue_id/non_comp_follow_ups/:id/;destroy', :controller => 'non_comp_follow_ups', :action => 'destroy'

  map.destroy_pppams_issue_follow_up 'pppams_issues/:pppams_issue_id/pppams_issue_follow_ups/:id/;destroy', :controller => 'pppams_issue_follow_ups', :action => 'destroy'

  map.destroy_pppams_issue 'pppams_issues/:id/destroy', :controller => 'pppams_issues', :action => 'destroy'

  map.destroy_non_comp_issue 'non_comp_issues/:id/destroy', :controller => 'non_comp_issues', :action => 'destroy'

  map.resources :non_comp_issues do |non_comp_issues|
     non_comp_issues.resources :non_comp_follow_ups, :name_prefix => nil
  end

  map.resources :pppams_issues do |pppams_issues|
     pppams_issues.resources :pppams_issue_follow_ups, :name_prefix => nil
  end



  map.start '', :controller => 'login', :action => 'index'
  map.reporting 'reports', :controller => 'reports', :action => 'index'
  map.position_reporting 'position_reports', :controller => 'position_reports', :action => 'index'
  map.forgot_password 'forgot_password', :controller => 'users', :action => 'forgot_password'
  map.reset_from_code '/reset_from_code/:password_reset_code', :controller => 'users', :action => 'reset_from_code'
  map.reset '/reset_password', :controller => 'users', :action => 'reset_password'
  map.connect ':controller/:action/:id'


>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
end
