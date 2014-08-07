class CreateConfigVars < ActiveRecord::Migration
  def change
    create_table :config_vars do |t|
      t.integer :config_file_id
      t.string :key
      t.string :value

      t.timestamps
    end
    add_index :config_vars, :config_file_id
    add_index :config_vars, [:config_file_id, :key], unique: true
  end
end
