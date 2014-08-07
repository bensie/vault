require "securerandom"

class App < ActiveRecord::Base

  has_many :config_files, dependent: :destroy

  validates_presence_of :name,
    :uuid,
    :environment

  default_value_for :uuid do
    SecureRandom.uuid
  end

  default_value_for :environment, "production"

  def regenerate_uuid!
    self.uuid = SecureRandom.uuid
    save!
  end

end
