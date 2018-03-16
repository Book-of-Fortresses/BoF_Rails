Rails.application.routes.draw do
  resources :perspective_drawings
  resources :images
  resources :collaborators
  resources :locations
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
