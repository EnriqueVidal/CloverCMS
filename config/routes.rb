Clover::Application.routes.draw do
  devise_for :users
    
  match ":section_name/:page_name.html",                  :to => "pages#show"
  match ":section_name/:subsection_name/:page_name.html", :to => "pages#show"
  
  resources :sections do
    resources :pages
  end
  
  root :to => "pages#show", :home_page => true
  # match ':controller(/:action(/:id(.:format)))'
end
