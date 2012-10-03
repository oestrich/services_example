Services::Application.routes.draw do
  devise_for :users

  resources :orders
end
