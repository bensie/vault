class ConfigFile < ActiveRecord::Base

  belongs_to :app

  has_many :config_vars, dependent: :destroy

  validates_presence_of :name

end
