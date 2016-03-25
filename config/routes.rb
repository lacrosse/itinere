Rails.application.routes.draw do
  controller :pages do
    root 'pages#landing'
  end
end
