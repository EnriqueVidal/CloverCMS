ActionController::Routing::Routes.draw do |map|

  map.resources :manager
  
  map.delete_page 'pages/:id/destroy',    :controller => 'pages',   :action => 'destroy'
  map.create_page 'pages/create',         :controller => 'pages',   :action => 'create'
  map.update_page 'pages/update',         :controller => 'pages',   :action => 'update'
  map.edit_page   'pages/:id/edit',       :controller => 'pages',   :action => 'edit'
  map.show_page   'pages/:id',            :controller => 'pages',   :action => 'show'
  map.resources   :pages
  
  map.add_subsection_page   'subsection/new_page/:id',                :controller => 'subsections',   :action => 'new_page'
  map.add_subsection        'subsection/add_subsection/:section_id',  :controller => 'subsections',   :action => 'add_subsection'
  map.subsection_items      'subsection/:id/items',                   :controller => 'subsections',   :action => 'items'
  map.resources             :subsections

  map.add_section_page  'section/new_page/:id',   :controller => 'sections',      :action => 'new_page'
  map.new_section       'section/new',            :controller => 'sections',      :action => 'new'
  map.section_items     'section/:id/items',      :controller => 'sections',      :action => 'items'
  map.resources         :sections

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
