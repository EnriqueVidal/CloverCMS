ActionController::Routing::Routes.draw do |map|

  map.resources :email_lists, :collection => { :add_to_list => :post }
  
  map.resources :contact_forms
  map.new_email 'contact', :controller => 'contact_forms', :action => 'new'
  

  map.resources     :meta_tags
  map.edit_meta_tag 'meta_tags/:id/edit',     :controller => 'meta_tags', :action => 'edit'

  map.resources     :uploads
  map.delete_upload 'uploads/:id/destroy',          :controller => 'uploads', :action => 'destroy'
  map.get_photos    'uploads/get_uploads/:page_id',  :controller => 'uploads', :action => 'get_uploads'


  map.show_subsection_page  ':section_name/:subsection_name/:page_name.html', :controller => 'viewer', :action => 'show_section_page'
  map.show_section_page     ':section_name/:page_name.html',                  :controller => 'viewer', :action => 'show_section_page'


  map.resources           :users
  map.show_user           'users/:username',        :controller => 'users',   :action => 'show'
  map.profile             'profile',                :controller => 'users',   :action => 'profile'
  map.activate            'users/activate/:token',  :controller => 'users',   :action => 'activate'
  map.login               'login',                  :controller => 'users',   :action => 'login'
  map.logout              'logout',                 :controller => 'users',   :action => 'logout'
  map.register            'register',               :controller => 'users',   :action => 'register'
  map.lost_password       'lost_password',          :controller => 'users',   :action => 'lost_password'
  map.change_password     'change_password',        :controller => 'users',   :action => 'change_password'


  map.resources   :sections,    :has_many   => [ :pages, :subsections ]
  map.manager     'manager',    :controller => 'sections', :action => 'index'
  
  map.resources   :subsections, :has_many   => :pages, :belongs_to => :section

  map.pick_onwer 'select_owner',  :controller => 'pages',   :action => 'select_owner'
  map.resources   :pages,         :belongs_to => [ :section, :subsection ]

  map.resources :people
  map.resources :members
  map.resources :admins

  map.root  :controller => :viewer, :action => :home_page

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
  map.connect '*path', :controller => 'four_oh_fours'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

