class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def permitted_params(params_hash)
    @permitted_params ||= PermittedParams.new(params_hash, nil)
  end
  helper_method :permitted_params

end
