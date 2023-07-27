Rails.application.routes.draw do
  devise_for :users

  get 'pages/privacy'
  get 'pages/terms'
  root "homes#top"
end
