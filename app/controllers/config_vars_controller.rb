class ConfigVarsController < ApplicationController

  before_action :find_app
  before_action :find_config_file
  before_action :find_config_var, only: [:show, :edit, :update, :destroy]

  def new
    @config_var = @config_file.config_vars.build
  end

  def create
    @config_var = @config_file.config_vars.create(permitted_params(params[:config_var]).config_var)
  end

  def edit
  end

  def update
    @config_var.update_attributes(permitted_params(params[:config_var]).config_var)
  end

  def destroy
    @config_var.destroy
  end

  private

  def find_app
    @app = App.where(uuid: params[:app_id]).first!
  end

  def find_config_file
    @config_file = @app.config_files.find(params[:config_file_id])
  end

  def find_config_var
    @config_var = @config_file.config_vars.find(params[:id])
  end

end
