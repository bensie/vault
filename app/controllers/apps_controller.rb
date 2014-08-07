class AppsController < ApplicationController

  def show
    @app = App.where(uuid: params[:id]).first!
  end

end
