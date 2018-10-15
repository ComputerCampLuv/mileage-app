Rails.application.routes.draw do
  root to: 'fills#index'
  resources :fills
end
