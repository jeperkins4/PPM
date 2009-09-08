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
                :contexts
  
  map.resources :incidents do |incidents|
     incidents.resources :follow_ups
  end

  map.destroy_non_comp_follow_up 'non_comp_issues/:non_comp_issue_id/non_comp_follow_ups/:id/;destroy', :controller => 'non_comp_follow_ups', :action => 'destroy'

  map.destroy_pppams_issue_follow_up 'pppams_issues/:pppams_issue_id/pppams_issue_follow_ups/:id/;destroy', :controller => 'pppams_issue_follow_ups', :action => 'destroy'

  map.destroy_pppams_issue 'pppams_issues/:id/destroy', :controller => 'pppams_issues', :action => 'destroy'

  map.destroy_non_comp_issue 'non_comp_issues/:id/destroy', :controller => 'non_comp_issues', :action => 'destroy'

  map.resources :non_comp_issues do |non_comp_issues|
     non_comp_issues.resources :non_comp_follow_ups
  end

  map.resources :pppams_issues do |pppams_issues|
     pppams_issues.resources :pppams_issue_follow_ups
  end



  map.start '', :controller => 'login', :action => 'index'
  map.reporting 'reports', :controller => 'reports', :action => 'index'
  map.position_reporting 'position_reports', :controller => 'position_reports', :action => 'index'
  map.forgot_password 'forgot_password', :controller => 'users', :action => 'forgot_password'
  map.reset_from_code '/reset_from_code/:password_reset_code', :controller => 'users', :action => 'reset_from_code'
  map.reset '/reset_password', :controller => 'users', :action => 'reset_password'
  map.connect ':controller/:action/:id'


end
