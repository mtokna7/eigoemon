Rails.application.routes.draw do
  devise_for :users
  resources :quizzes, only: %i[show index]


  get 'pages/privacy'
  get 'pages/terms'
  root "homes#top"
end
