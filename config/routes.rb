Clover::Application.routes.draw do
  devise_for :users

  match ":section_name/:page_name.html",                  :to => "pages#show", :as => :section_page
  match ":section_name/:subsection_name/:page_name.html", :to => "pages#show", :as => :subsection_page

  resources :assets
  resources :articles
  resources :authentications, :only => [ :index, :create, :destroy ]

  resources :sections,  :except => :show  do
    resources :pages,   :except => :show
  end

  root :to => "pages#show", :home_page => true
end