class CreateAuthTokens < ActiveRecord::Migration
  def change
    create_table :auth_tokens do |t|
      t.string :token
      t.boolean :remember

      t.timestamps null: false
    end
  end
end
