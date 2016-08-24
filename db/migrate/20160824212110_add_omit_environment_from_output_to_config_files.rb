class AddOmitEnvironmentFromOutputToConfigFiles < ActiveRecord::Migration
  def change
    add_column :config_files, :omit_environment_from_output, :boolean, default: false
  end
end
