class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.decimal :length
      t.decimal :width
      t.integer :layer
      t.integer :amount,  default: 0
      t.integer :pinban_style_num, default: 1
      t.integer :type
      t.decimal :thickness
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
      t.string  :express_no
      t.decimal :price, default: 0
      t.string  :pcb_file_path
      t.string  :comment
      t.integer :pay_type, default: 0
      t.string  :pay_id, limit: 16
      t.integer :pay_status
      t.integer :status, default: 1

      t.timestamps
    end
    add_index :orders, [:user_id, :created_at]
  end
end
