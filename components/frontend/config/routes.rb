Frontend::Engine.routes.draw do
  root to: "pages#competition"
  get 'competition', to: 'pages#competition'

end
