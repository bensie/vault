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
      :environment,
      :aws_access_key_id,
      :aws_secret_access_key,
      :aws_bucket,
      :s3_path_prefix,
      :sync_to_s3
    ]
  end

  def config_file_attributes
    [
      :name,
      :omit_environment_from_output
    ]
  end

  def config_var_attributes
    [
      :key,
      :value
    ]
  end

end
