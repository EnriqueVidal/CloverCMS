Clover::Application.routes.draw do
  resources :assets
  devise_for :users, :controllers => { :registrations => 'registrations' }

  match ":section_name/:page_name.html",                  :to => "pages#show"
  match ":section_name/:subsection_name/:page_name.html", :to => "pages#show"
  match "/auth/:provider/callback" => "authentications#create"
  resources :authentications, :only => [ :index, :create, :destroy ]
  
  resources :sections, :except => :show  do
    resources :pages, :except => :show
  end
  
  root :to => "pages#show", :home_page => true
  # match ':controller(/:action(/:id(.:format)))'
end
