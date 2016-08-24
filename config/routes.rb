Rails.application.routes.draw do
  resources :apps, only: [:show, :edit, :update] do
    member do
      post :rotate_uuid
    end
    resources :config_files, path: "files" do
      resources :config_vars, except: [:index]
    end
  end
end
