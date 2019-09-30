Rails.application.routes.draw do
  root to: "pages#competition"
  resources :matches

  # for last match. get 'registration', to: 'pages#show'
  # get '/:path', to: 'pages#show'
  get 'competition', to: 'pages#competition'
end
