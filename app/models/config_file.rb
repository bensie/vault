class ConfigFile < ActiveRecord::Base
  extend FriendlyId

  belongs_to :app

  has_many :config_vars, dependent: :destroy

  validates_presence_of :name

  friendly_id :name

  def api_hash
    hash = {}
    hash[app.environment] = {}

    config_vars.each do |cv|
      hash[app.environment][cv.key] = cv.value
    end
    hash
  end

end
