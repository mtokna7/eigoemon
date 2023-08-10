Rails.application.routes.draw do
  get 'explanations/programming'
  get 'explanations/english'
  devise_for :users
  resources :quizzes, only: %i[show index]
  resources :words, only: [:index]
  resources :users, only: [] do
    resources :dialogues, only: [:index]
  end  
  resources :explanations, only: [] do
    member do
      get :programming
      get :english
    end
  end
  namespace :api do
    namespace :v1 do
      resources :quizzes, only: [] do
        member do
          get :conversations
        end
      end
    end
  end

  get 'pages/privacy'
  get 'pages/terms'
  root "homes#top"
end