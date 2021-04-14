Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
 post '/attacheds/import/:id', to: 'attacheds#import', as: "attacheds_import" 
  resources :contacts do
    collection {post :import}
  end

  resources :attacheds do
    collection {post :create}
  end

  resources :fail_contacts, only: [:index, :show]

end
