class CreateOrders < ActiveRecord::Migration
  def up
    create_table :orders do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end

  def down
    drop_table :orders
  end
end
