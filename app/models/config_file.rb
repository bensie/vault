class ConfigFile < ActiveRecord::Base
  extend FriendlyId

  belongs_to :app

  has_many :config_vars, dependent: :destroy

  validates_presence_of :name, :app

  friendly_id :name

  def api_hash(options = {})
    hash = {}
    hash[app.environment] = {}

    config_vars.each do |cv|
      hash[app.environment][cv.key] = cv.value
    end

    if options[:omit_environment]
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

end
