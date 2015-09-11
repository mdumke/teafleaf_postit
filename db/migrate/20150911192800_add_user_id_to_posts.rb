class AddUserIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :user_id, :integer, after: :description
    add_index :posts, :user_id
  end
end
