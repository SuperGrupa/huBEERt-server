class DeleteColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :password
    remove_column :users, :authentication_token
  end
end
