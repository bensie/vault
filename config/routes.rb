Rails.application.routes.draw do

  resources :apps, only: [:show] do
    resources :config_files, only: [:show]
  end

end
