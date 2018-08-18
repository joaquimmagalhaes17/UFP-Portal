class CreateDeviceIds < ActiveRecord::Migration[5.2]
  def change
    create_table :device_ids do |t|
      t.references :user, foreign_key: { to_table: :users }, index: true
      t.text :device_id
      t.timestamps
    end
  end
end
