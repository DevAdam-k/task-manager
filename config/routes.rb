Rails.application.routes.draw do
  resources :tasks do
    member do
      patch :complete
    end
  end

  namespace :api, defaults: { format: :json } do
    resources :tasks, only: [ :index ]
  end

  root "tasks#index"
end
