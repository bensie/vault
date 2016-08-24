class AddAwsKeyAndBucketInfoToApps < ActiveRecord::Migration
  def change
    add_column :apps, :aws_access_key_id, :string
    add_column :apps, :aws_secret_access_key, :string
    add_column :apps, :aws_bucket, :string
    add_column :apps, :s3_path_prefix, :string
    add_column :apps, :sync_to_s3, :boolean, default: false, null: false
  end
end
