Rails.application.routes.draw do

  root to: 'home#index'
  get "/test", to: "home#test"
  resources :photos
  match '*path', via: :all, to: 'home#error_404'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
