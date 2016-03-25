Rails.application.routes.draw do
  controller :pages do
    root 'pages#landing'
  end

  devise_for :users

  resources :trip_plans, only: [:index, :show, :new, :edit, :create, :update]
  resources :published_trip_plans, only: :show, path: 't'
end
