class CreateIntercomDownloads < ActiveRecord::Migration[6.0]
  def change
    create_table :intercom_downloads do |t|
      t.text :file_data, null: false
      t.timestamps
    end
  end
end
