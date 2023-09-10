Rails.application.routes.draw do
  devise_for :users
  resources :quizzes, only: %i[show]
  resources :words, only: %i[index] do
    resource :favorite, only: %i[create destroy]
  end
  resources :conversations, only: %i[index]
  resources :tutorials, only: [] do
    get 'quiz_show', on: :member
    get 'quiz_explanation', on: :member
    get 'library_index', on: :collection
    get 'library_explanation/:word_id', to: 'tutorials#library_explanation', as: :library_explanation, on: :collection
  end
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
