Clover::Application.routes.draw do
  devise_for :users, :singular => :user

  match ":section_name/:page_name.html",                  :to => "pages#show", :as => :section_page,    :via => :get
  match ":section_name/:subsection_name/:page_name.html", :to => "pages#show", :as => :subsection_page, :via => :get
  match "/dashboard", :to => "dashboard/sections#index", :as => :dashboard_root, :via => :get

  namespace :dashboard do
    resources :articles
    resources :assets,    :only   => [ :create, :destroy ]
    resources :sections,  :except => :show  do
      resources :pages,   :except => :show
    end
  end

  root :to => "pages#show", :home_page => true, :via => :get
end
