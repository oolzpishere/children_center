Rails.application.routes.draw do
  mount Frontend::Engine   => '/', as: 'frontend'
  mount ChildrenMatch::Engine => '/', as: 'children_match'
  # mount Admin::Engine => '/', as: 'admin'


  # root to: "pages#competition"
  # resources :matches

  # for last match. get 'registration', to: 'pages#show'
  # get '/:path', to: 'pages#show'
  # get 'competition', to: 'pages#competition'
end
