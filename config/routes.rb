Rails.application.routes.draw do
  
  root 'tests#index'

  devise_for :users, path: :gurus, path_names: { sign_in: :login, sing_out: :logout }

  resources :tests, only: :index do
    member do
      post :start
    end
  end

  resources :test_passages, only: %i[show update] do
    resource :gists, only: :create
    
    member do
      get :result      
    end
  end

  namespace :admin do
    root 'tests#index'
    resources :tests do
      patch :update_inline, on: :member

      resources :questions, except: :index, shallow: true do
        resources :answers, except: :index, shallow: true
      end
    end

    resources :gists, only: :index
  end

end
