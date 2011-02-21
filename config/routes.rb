Clover::Application.routes.draw do
  devise_for :users

  resource :contact_form, :only => [ :create ]

  match "/dashboard",         :to => "dashboard/sections#index",  :as => :dashboard, :via => :get
  match "/dashboard/profile", :to => redirect("/users/edit"),     :as => :user_root, :via => :get

  namespace :dashboard do
    resources :users,     :only   => [ :index, :destroy, :edit, :update ]
    resources :assets,    :only   => [ :create, :destroy ]
    resources :settings,  :except => :show
    resources :articles,  :except => :show
    resources :sections,  :except => :show  do
      resources :pages,   :except => :show
    end
  end

  match ":section/:page",             :to => "pages#show", :as => :section_page,    :via => :get
  match ":section/:subsection/:page", :to => "pages#show", :as => :subsection_page, :via => :get

  root :to => "pages#home", :via => :get
end
