class ConfigFile < ActiveRecord::Base
  extend FriendlyId

  belongs_to :app

  has_many :config_vars, dependent: :destroy

  validates_presence_of :name, :app
  validates_uniqueness_of :name, scope: :app

  friendly_id :name, use: [:finders]

  def api_hash(options = {})
    hash = {}
    hash[app.environment] = {}

    config_vars.each do |cv|
      if cv.key.include?("/")
        parts = [app.environment] + cv.key.split("/")
        hash = configure_nested_hash_keys_for_key(hash, parts, cv.value)
      else
        hash[app.environment][cv.key] = cv.value
      end
    end

    if omit_environment_from_output
      hash[app.environment]
    else
      hash
    end
  end

  def copy_config_vars!(existing_config_file)
    save!
    existing_config_file.config_vars.each do |var|
      config_vars.where(key: var.key).first_or_create(value: var.value)
    end
  end

  def sync_to_s3!
    return if !app.sync_to_s3

    client = Aws::S3::Client.new(
      region:            "us-east-1",
      access_key_id:     app.aws_access_key_id,
      secret_access_key: app.aws_secret_access_key
    )
    client.put_object(
      acl:          "private",
      body:         api_hash.to_yaml,
      bucket:       app.aws_bucket,
      key:          app.s3_path_prefix.to_s + name + ".yml",
      content_type: "application/x-yaml"
    )
    client.put_object(
      acl:          "private",
      body:         api_hash.to_json,
      bucket:       app.aws_bucket,
      key:          app.s3_path_prefix.to_s + name + ".json",
      content_type: "application/json"
    )
  end

  private

  def configure_nested_hash_keys_for_key(hash, key_parts, value)
    current = key_parts.shift
    if current && key_parts.length > 0
      hash[current] ||= {}
      configure_nested_hash_keys_for_key(hash[current], key_parts, value)
    else
      hash[current] = value
    end
    hash
  end
end
