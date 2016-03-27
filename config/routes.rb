Rails.application.routes.draw do
  controller :pages do
    root 'pages#landing'
  end

  devise_for :users

  resources :trip_plans, only: [:index, :show, :new, :edit, :create, :update] do
    resources :trip_days, only: [:new, :edit, :create, :update, :destroy]
  end
  resources :published_trip_plans, only: :show, path: 't'
end
