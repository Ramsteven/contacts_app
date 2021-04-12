Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  get 'contacts/import' => 'contacts#my_import'
  get 'attacheds/upload' => 'attacheds#create'
  
  resources :contacts do
    collection {post :import}
  end

  resources :attacheds do
    collection {post :create}
  end

end
