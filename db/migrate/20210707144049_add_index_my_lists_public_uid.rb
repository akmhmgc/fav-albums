class AddIndexMyListsPublicUid < ActiveRecord::Migration[6.0]
  def change
    add_index :my_lists, :public_uid, unique: true
    add_column :my_lists, :nickname, :string
  end
end
