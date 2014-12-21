class ConfigFilesController < ApplicationController

  before_filter :find_app

  def show
    @config_file = @app.config_files.includes(:config_vars).friendly.find(params[:id])

    respond_to do |format|
      format.json {
        render json: @config_file.api_hash(display_options)
      }
      format.yml {
        render text: @config_file.api_hash(display_options).to_yaml, content_type: "text/yaml"
      }
      format.yaml {
        redirect_to url_for(format: :yml)
      }
      format.js
    end
  end

  def new
    @config_file = @app.config_files.build
  end

  def create
    @config_file = @app.config_files.create(permitted_params(params[:config_file]).config_file)
  end

  private

  def find_app
    @app = App.where(uuid: params[:app_id]).first!
  end

  def display_options
    options = {}
    options[:omit_environment] = true if params.has_key? :omit_environment
    options
  end

end
