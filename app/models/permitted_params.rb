class PermittedParams

  def initialize(params, user)
    @params = params
    @user = user
  end

  [
    :app,
    :config_file,
    :config_var
  ].each do |kind|
    define_method kind do
      @params.permit(*send("#{kind}_attributes"))
    end
  end

  def app_attributes
    [
      :name,
      :environment
    ]
  end

  def config_file_attributes
    [
      :name
    ]
  end

  def config_var_attributes
    [
      :key,
      :value
    ]
  end

end
