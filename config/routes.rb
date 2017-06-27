Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  resources :gpslocations
  
  match "settings/search_and_filter" => "settings#index", :via => [:get, :post], :as => :search_settings
  resources :settings do
    collection do
      post :batch
      get  :treeview
    end
    member do
      post :treeview_update
    end
  end 
  
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
