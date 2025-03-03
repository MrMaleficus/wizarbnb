class AddBaseInfosToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :nickname, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :github_id, :integer
    add_column :users, :house, :string
  end
end
