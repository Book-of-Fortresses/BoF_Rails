Rails.application.routes.draw do
  root "pages#show", page: "home"

  resources :locations, param: :slug, only: [:index, :show]
  resources :images, param: :slug, only: [:show]

  get ":page" => "pages#show"





end


# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
