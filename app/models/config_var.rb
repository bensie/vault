class ConfigVar < ActiveRecord::Base

  belongs_to :config_file

  validates_presence_of :key

  validates_uniqueness_of :key, scope: :config_file_id

end
