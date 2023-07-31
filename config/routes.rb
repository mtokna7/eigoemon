Rails.application.routes.draw do
  get 'explanations/programming'
  get 'explanations/english'
  devise_for :users
  resources :quizzes, only: %i[show index]
  resources :explanations, only: [] do
    member do
      get :programming
      get :english
    end
  end

  get 'pages/privacy'
  get 'pages/terms'
  root "homes#top"
end
