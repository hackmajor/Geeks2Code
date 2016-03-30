class AddSocialToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook, :string
    add_column :users, :instagram, :string
    add_column :users, :twitter, :string
  end
end
