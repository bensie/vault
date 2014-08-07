class CreateConfigFiles < ActiveRecord::Migration
  def change
    create_table :config_files do |t|
      t.integer :app_id
      t.string :name

      t.timestamps
    end
    add_index :config_files, :app_id
  end
end
