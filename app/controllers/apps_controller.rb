class AppsController < ApplicationController

  def show
    @app = App.where(uuid: params[:id]).includes(config_files: :config_vars).first!
  end

  def new
    @app = App.new
  end

  def create
    @app = App.new(permitted_params(params[:app]).app)
    redirect_to @app
  end

  def rotate_uuid
    @app = App.where(uuid: params[:id]).first!
    @app.regenerate_uuid!
    redirect_to @app
  end

end
