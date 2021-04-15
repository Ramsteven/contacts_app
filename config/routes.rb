Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  post '/attacheds/import/:id', to: 'attacheds#import', as: "attacheds_import" 
  delete '/destroy_all/:id', to: 'attacheds#destroyer', as: "destroy_all" 


  resources :contacts, only: [:create, :index]

  resources :attacheds, only: [:create, :index]
    # collection {post :create}
  # end

  resources :fail_contacts, only: [:index, :show]

 
end
