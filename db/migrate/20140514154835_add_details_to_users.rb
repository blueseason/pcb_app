class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
    add_column :users, :real_name, :string
    add_column :users, :qq, :string
    add_column :users, :company_name, :string
    add_column :users, :phone, :string
    add_column :users, :fax, :string
    add_column :users, :address, :string
    add_column :users, :province, :integer
    add_column :users, :city, :integer
    add_column :users, :last_login_time, :timestamp
    add_column :users, :login_count, :integer
    add_column :users, :level, :integer
    add_column :users, :points, :integer
  end
end
