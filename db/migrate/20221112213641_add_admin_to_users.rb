class AddAdminToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :admin, :boolean, default: false
  end
end

# note the syntax to add a migration:
# rails generate migration add_admin_to_users admin:boolean
