Rails.application.routes.draw do
  root 'apps#index'
  get 'admin', to: 'admin/schools#index'

  resources :apps, only: [:index]

  namespace :admin do
    resources :schools, :users
  end
end