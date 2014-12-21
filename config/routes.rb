Rails.application.routes.draw do

  resources :apps, only: [:show] do
    member do
      post :rotate_uuid
    end
    resources :config_files, path: "", only: [:show]
    resources :config_files, except: [:show] do
      resources :config_vars, except: [:index]
    end
  end

end
