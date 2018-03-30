Rails.application.routes.draw do

  resources :locations, param: :slug, only: [:index, :show]
  resources :images, param: :slug, only: [:show]

  root to: "home#index"

end


# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
