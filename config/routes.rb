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
                :employees
  
  map.resources :incidents do |incidents|
     incidents.resources :follow_ups
   end
  
  map.start '', :controller => 'login', :action => 'index'
  map.reporting 'reports', :controller => 'reports', :action => 'index'
  map.reset 'reset_password', :controller => 'users', :action => 'reset_password'
  map.connect ':controller/:action/:id'
end
