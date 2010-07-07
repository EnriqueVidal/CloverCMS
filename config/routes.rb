ActionController::Routing::Routes.draw do |map|

  # owner actions
  map.select_owner_snippet  '/snippets/select_owner', :controller => :snippets, :action => :select_owner
  map.select_owner_page     '/pages/select_owner',    :controller => :pages,    :action => :select_owner

  map.resources   :snippets,    :member     => { :delete => :get }
  map.resources   :pages,       :belongs_to => [ :section, :subsection ]
  map.resources   :articles,    :has_many   => [ :comments, :snippets ]
  map.devise_for  :users,       :has_many   => [ :articles, :comments ]
  map.resources   :sections,    :has_many   => [ :pages, :subsections ]
  map.resources   :subsections, :has_many   => :pages, :belongs_to => :section
  map.resources   :email_lists, :collection => { :add_to_list => :post }
  map.resources   :users
  map.resources   :contact_forms
  map.resources   :meta_tags
  map.resources   :uploads
  map.resources   :photos
  map.resources   :documents
  map.resources   :people
  #map.resources :members
  #map.resources :admins
  
  map.profile       'profile',              :controller => :users,          :action => :show
  map.edit_profile  'edit_profile',         :controller => :people,         :action => :edit
  map.new_email     'contact',              :controller => :contact_forms,  :action => :new
  map.edit_meta_tag 'meta_tags/:id/edit',   :controller => :meta_tags,      :action => :edit
  
  #viewer actions
  map.show_all_article      'articles/list',                                  :controller => :viewer, :action => :show_article_list  
  map.show_article_list     'articles/list/:type',                            :controller => :viewer, :action => :show_article_list
  map.show_article          ':username/articles/:article_name.html',          :controller => :viewer, :action => :show_article
  map.show_subsection_page  ':section_name/:subsection_name/:page_name.html', :controller => :viewer, :action => :show_section_page
  map.show_section_page     ':section_name/:page_name.html',                  :controller => :viewer, :action => :show_section_page
  
  map.manager 'manager',    :controller => 'sections', :action => 'index'
  map.root    :controller => :viewer, :action => :home_page

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

