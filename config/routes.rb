Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :users, only: %i[index destroy]
  end
  resources :quizzes, only: %i[show] do
    collection do
      get 'random_quiz'
    end
  end
  resources :review_quizzes, only: [:show] do
    get 'explanation', on: :member
    collection do
      get 'generate'
      get 'no_quizzes'
    end
  end
  resources :words, only: %i[index] do
    resource :favorite, only: %i[create destroy]
  end
  resources :favorites, only: %i[index show]
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

  get 'words/autocomplete', to: 'words#autocomplete', as: 'autocomplete_words'
  get 'tutorials/autocomplete', to: 'tutorials#autocomplete', as: 'tutorial_autocomplete_words'
  get 'pages/privacy'
  get 'pages/terms'
  root "homes#top"
end
