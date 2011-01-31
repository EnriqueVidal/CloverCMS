Clover::Application.routes.draw do
  devise_for :users

  match "/dashboard",         :to => "dashboard/sections#index",  :as => :dashboard, :via => :get
  match "/dashboard/profile", :to => redirect("/users/edit"),     :as => :user_root, :via => :get

  match ":section_name/:page_name",                  :to => "pages#show", :as => :section_page,    :via => :get
  match ":section_name/:subsection_name/:page_name", :to => "pages#show", :as => :subsection_page, :via => :get

  namespace :dashboard do
    resource  :site_config, :only => [ :edit, :update ]
    resources :users, :only => [ :index, :destroy, :edit, :update ]
    resources :articles
    resources :assets,    :only   => [ :create, :destroy ]
    resources :sections,  :except => :show  do
      resources :pages,   :except => :show
    end
  end

  root :to => "pages#show", :home_page => true, :via => :get
end
