class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name
      t.string :uuid
      t.string :environment

      t.timestamps
    end
  end
end
