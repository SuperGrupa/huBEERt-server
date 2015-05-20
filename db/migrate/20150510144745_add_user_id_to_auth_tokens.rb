class AddUserIdToAuthTokens < ActiveRecord::Migration
  def change
    add_reference :auth_tokens, :user, index: true
  end
end
