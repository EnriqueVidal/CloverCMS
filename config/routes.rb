Clover::Application.routes.draw do
  devise_for :users

  match ":section_name/:page_name.html",                  :to => "pages#show", :as => :section_page,    :via => :get
  match ":section_name/:subsection_name/:page_name.html", :to => "pages#show", :as => :subsection_page, :via => :get

  resources :assets
  resources :articles,  :only   => [ :create, :destroy ]
  resources :sections,  :except => :show  do
    resources :pages,   :except => :show
  end

  root :to => "pages#show", :home_page => true, :via => :get
end