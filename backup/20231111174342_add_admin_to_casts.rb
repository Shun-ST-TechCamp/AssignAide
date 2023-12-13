class AddAdminToCasts < ActiveRecord::Migration[7.0]
  def change
    add_column :casts, :admin, :boolean, default: false
  end
end
