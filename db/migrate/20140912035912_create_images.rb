class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :tag
      t.binary :binary_data
      t.string :filename
      t.string :content_type
      t.timestamps
    end
  end
end