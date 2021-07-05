class RemoveUserIdFromFavorites < ActiveRecord::Migration[5.2]
  def change
    remove_column :favorites, :user_id, :string
  end
end
