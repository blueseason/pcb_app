class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.decimal :length
      t.decimal :width
      t.integer :layer
      t.integer :amount
      t.integer :pinban_style_num
      t.integer :type
      t.integer :thickness
      t.integer :zuhan_color
      t.integer :zifu_color
      t.integer :hanpan_pengdu
      t.integer :zuhan_cover
      t.integer :test
      t.integer :tongbo_thickness
      t.integer :produce_time
      t.integer :need_receipt
      t.integer :if_in_province
      t.integer :express
      t.decimal :price
      t.string  :comment

      t.timestamps
    end
    add_index :orders, [:user_id, :created_at]
  end
end
