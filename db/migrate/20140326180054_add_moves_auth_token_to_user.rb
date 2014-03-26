class AddMovesAuthTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :moves_auth_token, :text
  end
end
