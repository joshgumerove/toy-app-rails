class AddRememberDigestToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :remember_digest, :string
  end
end

# note how we created this migration to add a remember_digest attribute to users
# rails generate migration add_remember_digest_to_users remember_digest:string